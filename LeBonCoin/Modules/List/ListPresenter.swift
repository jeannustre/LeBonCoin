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
    /// The currently selected category
    var currentCategory: Category?
    
    var safeListings: [Listing] {
        var l = self.listings
        l?.sort(by: { $0.creationDate ?? Date() < $1.creationDate ?? Date() }) // There must be some less ugly way but oh well
        l?.sort(by: { $0.isUrgent && !$1.isUrgent })
        if let filterCategory = currentCategory {
            return l?.filter({ $0.category == filterCategory.id }) ?? []
        }
        return l ?? []
    }

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
        return safeListings.count
    }
    
    /// Returns the listing for the specified index.
    func listing(at indexPath: IndexPath) -> ListingViewModel? {
        let listing = safeListings[indexPath.row]
        return ListingViewModel(listing: listing, categories: categories)
    }
    
    /// A listing has been selected, so navigate to the detail page
    func listingTapped(at indexPath: IndexPath) {
        guard let listing = listing(at: indexPath) else { return }
        router?.navigateToDetail(from: view, with: listing)
    }
    
    /// Returns a `FilterButton` initialized  from the current categories.
    func getFilterButton() -> FilterButton {
        let filterButton: FilterButton = FilterButton(categories: categories ?? [])
        filterButton.delegate = self
        return filterButton
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
    func getListingsError(error: Error?) {
        view?.getListingsError()
    }
    
    func getCategoriesSuccess(response: [Category]) {
        self.categories = response
    }
    
    func getCategoriesError(error: Error?) {
        view?.getListingsError()
    }
    
}

extension ListPresenter: FilterButtonDelegate {
    
    func filterButton(filterButton: FilterButton, didSelectCategory category: Category?) {
        currentCategory = category
        view?.reloadTable()
    }
    
    func filterButtonDidSelectAllCategories(filterButton: FilterButton) {
        currentCategory = nil
        view?.reloadTable()
    }
    
    func filterButton(filterButton: FilterButton, asksToPresentAlertController controller: UIAlertController) {
        view?.presentController(controller)
    }
    
}
