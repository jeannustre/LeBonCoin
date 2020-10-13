//
//  ListPresenter.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// The Presenter for the List module.
final class ListPresenter: ListViewToPresenterProtocol {

    /// Reference to the view.
    weak var view: ListPresenterToViewProtocol?
    /// Reference to the interactor.
    var interactor: ListPresenterToInteractorProtocol?
    /// Reference to the router.
    var router: ListPresenterToRouterProtocol?
    /// The fetched listings for the current module
    var listings: [Listing]?
    /// The fetched categories
    var categories: [Category]?

    /// Initializes a `ListPresenter` from a view, interactor and router.
    init(view: ListPresenterToViewProtocol?, interactor: ListPresenterToInteractorProtocol?, router: ListPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    /// Called by the view within its own `viewDidLoad`
    func viewDidLoad() {
        fetchCategories()
        fetchListings()
    }
    
    /// Called to load categories from the API. Also called by `viewDidLoad`.
    func fetchCategories() {
        interactor?.getCategories()
    }
    
    /// Called to load listings from the API. Also called by `viewDidLoad`.
    func fetchListings() {
        interactor?.getListings()
    }
    
    /// Called by the view when the table needs to know the amount of cells to display
    func numberOfListings() -> Int {
        return listings?.count ?? 0
    }
    
    /// Returns the listing for the specified index.
    func listing(at indexPath: IndexPath) -> ListingViewModel? {
        guard let listing = listings?[indexPath.row] else { return nil }
        return ListingViewModel(listing: listing, categories: categories)
    }
    
    /// A listing has been selected, so navigate to the detail page
    func listingTapped(at indexPath: IndexPath) {

    }
  
}

/// Extension used to pass information from the interactor to the presenter.
extension ListPresenter: ListInteractorToPresenterProtocol {

    /// Called on fetch listings success
    func getListingsSuccess(response: [Listing]) {
        self.listings = response
        view?.gotListings()
    }
    
    /// Called on fetch listings failure
    func getListingsError(error: Error) {
        view?.getListingsError()
    }
    
    func getCategoriesSuccess(response: [Category]) {
        self.categories = response
    }
    
    func getCategoriesError(error: Error) {
        view?.getListingsError()
    }
    
}
