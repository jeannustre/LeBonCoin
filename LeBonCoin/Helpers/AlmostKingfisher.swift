//
//  AlmostKingfisher.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 14/10/2020.
//

import UIKit

/// An extension used to convert an `URL` to a saveable filename.
extension URL {
    
    /// Creates a saveable filename by joining all path components with a `.` separator.
    func saveableFileString() -> String {
        return pathComponents.joined(separator: ".")
    }
    
}

/// A class used to manage images stors in the app's Documents directory.
class LocalImageManager {
    
    /// The `Error` type related to the `LocalImageManager`.
    enum LocalImageManagerError: Error {
        /// Used when the images directory URL could not be created.
        case imagesDirectoryURLNotValid
    }
    
    /// Static shared instance, used to make this class a singleton (since its initializer is private)
    static let shared = LocalImageManager()
    /// The `FileManager` instance used to read and write local files.
    private let fileManager: FileManager = FileManager()
    /// The name of the `Images` sub-directory, where images are saved.
    private let imagesDirectoryName: String = "Images"
    
    /// A lazy variable used to create the full URL for the `Documents/Images` directory.
    private lazy var imagesDirectoryURL: URL? = {
        let documentsURL: URL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let imagesDirectoryPath = documentsURL.appendingPathComponent(imagesDirectoryName)
        return imagesDirectoryPath
    }()
    
    /// Private initialize to make this a singleton.
    private init() {
        try? createImagesDirectoryIfNeeded()
    }
    
    /// If the ~/Documents/Images/ directory doesn't exist, creates it.
    func createImagesDirectoryIfNeeded() throws {
        guard let imagesDirectoryURL = imagesDirectoryURL else {
            throw LocalImageManagerError.imagesDirectoryURLNotValid
        }
        if (try? imagesDirectoryURL.checkResourceIsReachable()) ?? false { return }
        do {
            try fileManager.createDirectory(at: imagesDirectoryURL, withIntermediateDirectories: false)
        } catch {
            throw error
        }
    }
    
    /// Whether a local image exists for the distant URL.
    func imageExists(for url: URL) -> Bool {
        guard let fileURL = imagesDirectoryURL?.appendingPathComponent(url.saveableFileString()) else {
            return false
        }
        if fileManager.fileExists(atPath: fileURL.path) {
            return true
        }
        return false
    }
    
    /// Returns a local image from a distant URL if one exists, nil otherwise.
    func getImage(for url: URL) -> UIImage? {
        guard let fileURL = imagesDirectoryURL?.appendingPathComponent(url.saveableFileString()) else {
            return nil
        }
        do {
            let data = try Data(contentsOf: fileURL)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
    
    /// Saves the specified image data in the ~/Documents/Images/ directory, under the specified name.
    func save(imageData: Data, name: String) {
        guard let destinationFilename = imagesDirectoryURL?.appendingPathComponent(name) else {
            return
        }
        try? imageData.write(to: destinationFilename)
    }
    
    /// Downloads an image, stores it locally, and calls the completion block with the fetched image.
    func downloadImage(url: URL, completion: ((UIImage?)->Void)?) -> URLSessionDownloadTask {
        let task = URLSession.shared.downloadTask(with: url) { [weak self] localURL, urlResponse, error in
            if let e = error as NSError? {
                if e.code == NSURLErrorCancelled {
                    print("Cancelled task")
                }
            }
            guard let localURL = localURL, let imageData = try? Data(contentsOf: localURL), let image = UIImage(data: imageData) else {
                completion?(nil)
                return
            }
            // Save it for next time
            self?.save(imageData: imageData, name: url.saveableFileString())
            // Return the image
            completion?(image)
            
        }
        return task
    }
    
}

/// An extension on UIImageView used to load images, much like Kingfisher or SDWebImage.
extension UIImageView {
    
    /// Replaces the image within the imageView, optionally animated.
    func replaceImage(newImage: UIImage?, animated: Bool) {
        if newImage == nil { // skip all animations
            image = newImage
            return
        }
        if newImage != nil && image != nil {
            return
        }
        if image == nil && newImage != nil {
            UIView.transition(with: self,
                              duration: animated ? 0.5 : 0,
                              options: .transitionCrossDissolve,
                              animations: { self.image = newImage },
                              completion: nil)
        }
        
    }
    
    /// Custom extension used to either load an image from a distant URL and save it,
    /// or directly retrieve it from cache if it's been downloaded already.
    /// - parameter url: The distant URL of an image resource.
    /// - parameter placeholder: A placeholder image to use until the image is loaded.
    /// - parameter animated: Whether to use a crossfade animation when replacing the image, only from a real async task.
    func asyncLoad(from url: URL?, placeholder: UIImage? = nil, animated: Bool, completion: @escaping (UIImage?)->Void) -> URLSessionDownloadTask? {
        guard let url = url else {
            image = placeholder
            completion(placeholder)
            return nil
        }
        if let localImage = LocalImageManager.shared.getImage(for: url) {
            image = localImage
            completion(localImage)
            return nil
        }
        if image == nil { image = placeholder }
        let task = LocalImageManager.shared.downloadImage(url: url, completion: { [weak self] downloadedImage in
            DispatchQueue.main.async {
                self?.replaceImage(newImage: downloadedImage, animated: animated)
                completion(downloadedImage)
            }
        })
        task.resume()
        return task
    }
    
    
}
