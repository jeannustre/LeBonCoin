//
//  DetailPresenter.swift
//  LeBonCoin
//
//  Created Jean Sarda on 17/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

/// The Presenter for the Detail module.
final class DetailPresenter: DetailViewToPresenterProtocol {
    /// Reference to the view.
    weak var view: DetailPresenterToViewProtocol?
    /// Reference to the interactor.
    var interactor: DetailPresenterToInteractorProtocol?
    /// Reference to the router.
    var router: DetailPresenterToRouterProtocol?
    /// The view model representing the Listing.
    var viewModel: ListingViewModel

    /// Initializes a `DetailPresenter` from a view, interactor and router.
    init(view: DetailPresenterToViewProtocol?, interactor: DetailPresenterToInteractorProtocol?, router: DetailPresenterToRouterProtocol?, viewModel: ListingViewModel) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
    
    /// Called by the view when it needs its `ListingViewModel`.
    func getListingViewModel() -> ListingViewModel {
        return viewModel
    }
    
}

/// Extension used to pass information from the interactor to the presenter.
extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
}
