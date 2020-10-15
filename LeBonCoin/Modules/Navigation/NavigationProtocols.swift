//
//  NavigationProtocols.swift
//  LeBonCoin
//
//  Created Jean Sarda on 15/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// Delegates from the presenter (business rules) to the view (ui)
protocol NavigationPresenterToViewProtocol: class {
}

/// Delegates from the interactor (api/storage) to the presenter (business rules)
protocol NavigationInteractorToPresenterProtocol: class {
}

/// Delegates from the presenter (business rules) to the interactor (api/storage)
protocol NavigationPresenterToInteractorProtocol: class {
    /// Reference to the presenter.
    var presenter: NavigationInteractorToPresenterProtocol? { get set }
}

/// Delegates from the view (ui) to the presenter (business rules)
protocol NavigationViewToPresenterProtocol: class {
    /// Reference to the view.
    var view: NavigationPresenterToViewProtocol? { get set }
    /// Reference to the interactor.
    var interactor: NavigationPresenterToInteractorProtocol? { get set }
    /// Reference to the router.
    var router: NavigationPresenterToRouterProtocol? { get set }
}

/// Delegates from the presenter (business rules) to the router (navigation)
protocol NavigationPresenterToRouterProtocol: class {
    /// Creates the module.
    static func createModule() -> UIViewController
}
