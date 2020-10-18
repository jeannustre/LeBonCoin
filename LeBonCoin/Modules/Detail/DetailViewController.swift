//
//  DetailViewController.swift
//  LeBonCoin
//
//  Created Jean Sarda on 17/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// The Detail view controller. Subclass of UIViewController.
class DetailViewController: UIViewController {

    /// A reference to the view's presenter.
	var presenter: DetailViewToPresenterProtocol?
    /// A reference to the current loading task for getting the image - allows us to cancel the request in deinit().
    private var imageLoadingTask: URLSessionDownloadTask?
    
    /// The main image view.
    private lazy var listingImageView: UIImageView = {
       let listingImageView = UIImageView()
        listingImageView.translatesAutoresizingMaskIntoConstraints = false
        listingImageView.contentMode = .scaleAspectFit
        return listingImageView
    }()
    
    /// The label used to display the listing's title.
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = NamedColors.leBonConstrast
        titleLabel.font = DMSansFont.medium.font(size: 24)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        return titleLabel
    }()
    
    /// The label used to display the listing's price.
    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.textColor = NamedColors.leBonAccent
        priceLabel.textAlignment = .right
        priceLabel.font = DMSansFont.bold.font(size: 26.0)
        return priceLabel
    }()
    
    /// The view used to display the listing's category.
    private lazy var categoryView: CategoryView = {
        let categoryView = CategoryView(category: nil)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        return categoryView
    }()
    
    /// The label used to indicate whether the listing is marked as urgent.
    private lazy var urgentLabel: UILabel = {
        let urgentLabel = UILabel()
        urgentLabel.translatesAutoresizingMaskIntoConstraints = false
        urgentLabel.textColor = NamedColors.leBonUrgent
        urgentLabel.textAlignment = .left
        urgentLabel.font = DMSansFont.regular.font(size: 22.0)
        return urgentLabel
    }()
    
    /// The multiline description label.
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textColor = NamedColors.leBonConstrast
        descriptionLabel.textAlignment = .left
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.font = DMSansFont.regular.font(size: 16.0)
        descriptionLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 100), for: .vertical)
        return descriptionLabel
    }()
    
    /// A container view used to arrange content within the `scrollView`.
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    /// An `UIScrollView` used to make the page scrollable. Only has a single child, `containerView`.
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    /// Initializes the view controller.
    init() {
        super.init(nibName: nil, bundle: nil)
        commonInit()
    }
    
    /// IB bad
    required init?(coder: NSCoder) {
        fatalError("👎")
    }
    
    /// When letting go of the current module, cancel the current image loading request. Should ideally be done in the interactor.
    deinit {
        imageLoadingTask?.cancel()
        imageLoadingTask = nil
    }
    
    /// When the view controller is about to be displayed, configure its content.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        listingImageView.sizeToFit()
    }
    
    /// Set the bg color and adds the subviews.
    private func commonInit() {
        view.backgroundColor = NamedColors.leBonBackground
        addSubviews()
        pinSubviews()
    }
 
    /// Adds all subviews.
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(listingImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(urgentLabel)
        containerView.addSubview(categoryView)
        containerView.addSubview(descriptionLabel)
        
    }
    
    /// Constraints all views.
    private func pinSubviews() {
        pinScrollView()
        pinContainerView()
        pinListingImageView()
        pinTitleLabel()
        pinPriceLabel()
        pinUrgentLabel()
        pinCategoryView()
        pinDescriptionLabel()
    }
    
    /// Pins the scroll view.
    private func pinScrollView() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    /// Pins the container view.
    private func pinContainerView() {
        containerView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    /// Pins the image view.
    private func pinListingImageView() {
        listingImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        listingImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        listingImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    }
    
    /// Pins the title.
    private func pinTitleLabel() {
        titleLabel.topAnchor.constraint(equalTo: listingImageView.bottomAnchor, constant: 12).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Pins the price label.
    private func pinPriceLabel() {
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
    }
    
    /// Pins the urgent label.
    private func pinUrgentLabel() {
        urgentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        urgentLabel.leadingAnchor.constraint(equalTo: categoryView.trailingAnchor, constant: 12).isActive = true
        urgentLabel.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
    }
    
    /// Pins the category view.
    private func pinCategoryView() {
        categoryView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12).isActive = true

        categoryView.heightAnchor.constraint(equalTo: priceLabel.heightAnchor).isActive = true
    }
    
    /// Pins the description label.
    private func pinDescriptionLabel() {
        descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 12).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12).isActive = true
    }
    
    /// Configures the view controller for the current `Listing`.
    private func configure() {
        guard let viewModel = presenter?.getListingViewModel() else { return }
        imageLoadingTask = listingImageView.asyncLoad(from: viewModel.smallImageUrl() ?? viewModel.thumbImageUrl(), animated: true) { [weak self] image in
            guard let image = image else { return }
            let width = image.size.width
            let height = image.size.height
            let screenWidth = self?.view.bounds.width ?? 0
            let viewHeight = screenWidth * height / width
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.3, animations: { [weak self] in
                    self?.listingImageView.heightAnchor.constraint(equalToConstant: viewHeight).isActive = true
                    self?.view.layoutIfNeeded()
                })
            }
        }
        titleLabel.text = viewModel.listingTitle()
        priceLabel.text = viewModel.listingPrice()
        descriptionLabel.text = viewModel.listingDescription()
        urgentLabel.text = viewModel.urgentString()
        categoryView.category = viewModel.category()
    }

}

/// An extension of the Detail view controller, used to get info back from the Presenter.
extension DetailViewController: DetailPresenterToViewProtocol {
    
}
