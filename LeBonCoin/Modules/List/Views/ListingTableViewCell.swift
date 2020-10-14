//
//  ListingTableViewCell.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

class ListingTableViewCell: UITableViewCell {

    private var imageLoadingTask: URLSessionDownloadTask?
    
    static let tableViewReuseIdentifier: String = "listingTableViewCell"
    
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
    
    private lazy var urgentLabel: UILabel = {
        let urgentLabel = UILabel()
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.textColor = NamedColors.leBonUrgent
        urgentLabel.textAlignment = .left
        urgentLabel.font = DMSansFont.regular.font(size: 22.0)
        return urgentLabel
    }()
    
    private lazy var categoryView: CategoryView = {
        let categoryView = CategoryView(category: nil)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        addSubviews()
        pinSubviews()
    }
 
    private func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(thumbnailImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(urgentLabel)
        containerView.addSubview(categoryView)
    }
    
    private func pinSubviews() {
        pinContainerView()
        pinThumbnailImageView()
        pinTitleLabel()
        pinCategoryView()
        pinPriceLabel()
        pinUrgentLabel()
    }
    
    private func pinContainerView() {
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor, constant: 6).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6).isActive = true
    }
    
    private func pinThumbnailImageView() {
        thumbnailImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        thumbnailImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
        thumbnailImageView.heightAnchor.constraint(equalTo: thumbnailImageView.widthAnchor).isActive = true
    }
    
    private func pinTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    private func pinCategoryView() {
        categoryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        categoryView.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    private func pinPriceLabel() {
        priceLabel.topAnchor.constraint(greaterThanOrEqualTo: categoryView.bottomAnchor, constant: 12).isActive = true
        priceLabel.leadingAnchor.constraint(lessThanOrEqualTo: urgentLabel.trailingAnchor, constant: 12).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        priceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }
    
    private func pinUrgentLabel() {
        urgentLabel.topAnchor.constraint(greaterThanOrEqualTo: categoryView.bottomAnchor, constant: 12).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 12).isActive = true
        urgentLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        urgentLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with listing: ListingViewModel?) {
        imageLoadingTask = thumbnailImageView.asyncLoad(from: listing?.thumbImageUrl() ?? listing?.smallImageUrl(), animated: true) { image in }
        titleLabel.text = listing?.listingTitle()
        priceLabel.text = listing?.listingPrice()
        urgentLabel.text = listing?.urgentString()
        categoryView.category = listing?.category()
    }
    
    func clearContent() {
        titleLabel.text = nil
        priceLabel.text = nil
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
        thumbnailImageView.image = nil
    }

}
