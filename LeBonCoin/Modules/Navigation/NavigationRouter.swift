//
//  NavigationRouter.swift
//  LeBonCoin
//
//  Created Jean Sarda on 15/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// The router for the Navigation module.
class NavigationRouter: NavigationPresenterToRouterProtocol {
    
    /// Initializes and returns the whole module.
    /// - Returns: a `NavigationViewController` containing the `ListViewController`.
    static func createModule() -> UIViewController {
        let view = NavigationViewController()
        let interactor: NavigationPresenterToInteractorProtocol = NavigationInteractor()
        let router: NavigationPresenterToRouterProtocol = NavigationRouter()
        let presenter: NavigationViewToPresenterProtocol & NavigationInteractorToPresenterProtocol = NavigationPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        let listViewController = ListRouter.createModule()
        view.setViewControllers([listViewController], animated: false)
        
        return view
    }
}
