//
//  ListInteractor.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import Foundation

/// The interactor for the List module.
final class ListInteractor: ListPresenterToInteractorProtocol {
    
    /// Reference to the module's presenter.
    weak var presenter: ListInteractorToPresenterProtocol?
    /// This interactor's URLSession. Used to perform network calls from this module.
    private var urlSession: URLSession = URLSession(configuration: .default)
    
    /// Fetches the listings.
    func getListings() {
        if CommandLine.arguments.contains("--uitesting") {
            presenter?.getListingsSuccess(response: loadMockListings())
        } else {
            let request = Routes.getListings.urlRequest
            urlSession.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.getListingsError(error: error)
                    }
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode([Listing].self, from: data)
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.getListingsSuccess(response: decoded)
                    }
                } catch {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.getListingsError(error: error)
                    }
                }
            }).resume()
        }
    }
    
    /// Fetches categories.
    func getCategories() {
        if CommandLine.arguments.contains("--uitesting") {
            presenter?.getCategoriesSuccess(response: loadMockCategories())
        } else {
            let request = Routes.getCategories.urlRequest
            urlSession.dataTask(with: request, completionHandler: { [weak self] data, response, error in
                guard let data = data, let decoded = try? JSONDecoder().decode([Category].self, from: data) else {
                    DispatchQueue.main.async { [weak self] in
                        self?.presenter?.getCategoriesError(error: error)
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    self?.presenter?.getCategoriesSuccess(response: decoded)
                }
            }).resume()
        }
    }
    
    /// Loads a listings response from the TestData.json local file.
    private func loadMockListings() -> [Listing] {
        let url = Bundle.main.url(forResource: "TestData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([Listing].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
    /// Loads a categories response from the TestCategories.json local file.
    private func loadMockCategories() -> [Category] {
        let url = Bundle.main.url(forResource: "TestCategories", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Category].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
}
