//
//  ListingTableViewCell.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

/// The `UITableViewCell` used to represent a `Listing`.
class ListingTableViewCell: UITableViewCell {
    /// A reference to the current image loading task, used to cancel it when the cell is reused.
    private var imageLoadingTask: URLSessionDownloadTask?
    /// The reuse identifier for this cell.
    static let tableViewReuseIdentifier: String = "listingTableViewCell"
    
    /// The container view.
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.masksToBounds = false
        containerView.layer.cornerRadius = 15
        if #available(iOS 13.0, *) {
            containerView.layer.cornerCurve = .continuous
        }
        containerView.backgroundColor = NamedColors.leBonElement
        return containerView
    }()
    
    /// The image view used to display the listing's thumbnail.
    private lazy var thumbnailImageView: UIImageView = {
        let thumbnailImageView = UIImageView()
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        thumbnailImageView.layer.masksToBounds = false
        thumbnailImageView.layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            thumbnailImageView.layer.cornerCurve = .continuous
        }
        thumbnailImageView.backgroundColor = .clear
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        return thumbnailImageView
    }()
    
    /// The label used to display the listing's title.
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = NamedColors.leBonConstrast
        titleLabel.font = DMSansFont.medium.font(size: 18)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        return titleLabel
    }()
    
    /// The label used to display the listing's price.
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = NamedColors.leBonAccent
        priceLabel.textAlignment = .right
        priceLabel.font = DMSansFont.bold.font(size: 20.0)
        return priceLabel
    }()
    
    /// The label used to indicate whether the `Listing` is urgent.
    private lazy var urgentLabel: UILabel = {
        let urgentLabel = UILabel()
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.textColor = NamedColors.leBonUrgent
        urgentLabel.textAlignment = .left
        urgentLabel.font = DMSansFont.regular.font(size: 22.0)
        return urgentLabel
    }()
    
    /// The `CategoryView` used to display the `Listing`'s `Category`.
    private lazy var categoryView: CategoryView = {
        let categoryView = CategoryView(category: nil)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    /// Initializes from a cell style and reuse identifier.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    /// Initializes from Interface Builder.
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    /// Common initializer.
    private func commonInit() {
        backgroundColor = .clear
        addSubviews()
        pinSubviews()
    }
 
    /// Adds all subviews.
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(urgentLabel)
        containerView.addSubview(categoryView)
    }
    
    /// Pins all subviews.
    private func pinSubviews() {
        pinContainerView()
        pinThumbnailImageView()
        pinTitleLabel()
        pinCategoryView()
        pinPriceLabel()
        pinUrgentLabel()
    }
    
    /// Pins the `containerView`.
    private func pinContainerView() {
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    }
    
    /// Pins the `thumbnailImageView`.
    private func pinThumbnailImageView() {
        thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor).isActive = true
    }
    
    /// Pins the `titleLabel`.
    private func pinTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Pins the `categoryView`.
    private func pinCategoryView() {
        categoryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        categoryView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Pins the `priceLabel`.
    private func pinPriceLabel() {
        priceLabel.topAnchor.constraint(greaterThanOrEqualTo: categoryView.bottomAnchor, constant: 12).isActive = true
        priceLabel.leadingAnchor.constraint(lessThanOrEqualTo: urgentLabel.trailingAnchor, constant: 12).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }
    
    /// Pins the `urgentLabel`.
    private func pinUrgentLabel() {
        urgentLabel.topAnchor.constraint(greaterThanOrEqualTo: categoryView.bottomAnchor, constant: 12).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        urgentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }

    /// Configures the cell with an optional `ListingViewModel`.
    func configure(with listing: ListingViewModel?) {
        imageLoadingTask = thumbnailImageView.asyncLoad(from: listing?.thumbImageUrl() ?? listing?.smallImageUrl(), animated: true) { image in }
        titleLabel.text = listing?.listingTitle()
        priceLabel.text = listing?.listingPrice()
        urgentLabel.text = listing?.urgentString()
        categoryView.category = listing?.category()
    }
    
    /// Clears all content before reuse.
    func clearContent() {
        titleLabel.text = nil
        priceLabel.text = nil
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
        thumbnailImageView.image = nil
    }

}
