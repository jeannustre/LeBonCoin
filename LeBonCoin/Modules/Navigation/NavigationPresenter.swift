//
//  NavigationPresenter.swift
//  LeBonCoin
//
//  Created Jean Sarda on 15/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

/// The Presenter for the Navigation module.
final class NavigationPresenter: NavigationViewToPresenterProtocol {

    /// Reference to the view.
    weak var view: NavigationPresenterToViewProtocol?
    /// Reference to the interactor.
    var interactor: NavigationPresenterToInteractorProtocol?
    /// Reference to the router.
    var router: NavigationPresenterToRouterProtocol?

    /// Initializes a `NavigationPresenter` from a view, interactor and router.
    init(view: NavigationPresenterToViewProtocol?, interactor: NavigationPresenterToInteractorProtocol?, router: NavigationPresenterToRouterProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

/// Extension used to pass information from the interactor to the presenter.
extension NavigationPresenter: NavigationInteractorToPresenterProtocol {
    
}
