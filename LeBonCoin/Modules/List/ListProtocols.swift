//
//  ListProtocols.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// Delegates from the presenter (business rules) to the view (ui)
protocol ListPresenterToViewProtocol: class {
    /// Called when listings were fetched successfully
    func gotListings()
    /// Called when listings couldn't be fetched
    func getListingsError()
}

/// Delegates from the interactor (api/storage) to the presenter (business rules)
protocol ListInteractorToPresenterProtocol: class {
    /// Called on fetch listings success
    func getListingsSuccess(response: [Listing])
    /// Called on fetch listings failure
    func getListingsError(error: Error)
    /// Called when categories were fetched successfully
    func getCategoriesSuccess(response: [Category])
    /// Called when categories couldn't be fetched
    func getCategoriesError(error: Error)
}

/// Delegates from the presenter (business rules) to the interactor (api or storage)
protocol ListPresenterToInteractorProtocol: class {
    /// Reference to the presenter.
    var presenter: ListInteractorToPresenterProtocol? { get set }
    /// Used to fetch listings
    func getListings()
    /// Used to fetch categories
    func getCategories()
}

/// Delegates from the view (ui) to the presenter (business rules)
protocol ListViewToPresenterProtocol: class {
    /// Reference to the view.
    var view: ListPresenterToViewProtocol? { get set }
    /// Reference to the interactor.
    var interactor: ListPresenterToInteractorProtocol? { get set }
    /// Reference to the router.
    var router: ListPresenterToRouterProtocol? { get set }
    /// Called when the view just loaded.
    func viewDidLoad()
    /// Called when the presenter should ask the interactor to fetch the listings.
    func fetchListings()
    /// Called by the view to get the number of rows to display
    func numberOfListings() -> Int
    /// Returns the Listing for the specified index
    func listing(at indexPath: IndexPath) -> ListingViewModel?
    /// Tells the presenter a Listing has been tapped
    func listingTapped(at indexPath: IndexPath)
}

/// Delegates from the presenter (business rules) to the router (navigation)
protocol ListPresenterToRouterProtocol: class {
    /// Creates the module.
    static func createModule() -> ListViewController
    /// Navigate to detail module
    func navigateToDetail(from view: ListPresenterToViewProtocol?, with listing: ListingProtocol)
}
