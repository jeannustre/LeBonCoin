//
//  DetailProtocols.swift
//  LeBonCoin
//
//  Created Jean Sarda on 17/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// Delegates from the presenter (business rules) to the view (ui)
protocol DetailPresenterToViewProtocol: class {
}

/// Delegates from the interactor (api/storage) to the presenter (business rules)
protocol DetailInteractorToPresenterProtocol: class {
}

/// Delegates from the presenter (business rules) to the interactor (api/storage)
protocol DetailPresenterToInteractorProtocol: class {
    /// Reference to the presenter.
    var presenter: DetailInteractorToPresenterProtocol? { get set }
}

/// Delegates from the view (ui) to the presenter (business rules)
protocol DetailViewToPresenterProtocol: class {
    /// Reference to the view.
    var view: DetailPresenterToViewProtocol? { get set }
    /// Reference to the interactor.
    var interactor: DetailPresenterToInteractorProtocol? { get set }
    /// Reference to the router.
    var router: DetailPresenterToRouterProtocol? { get set }
    /// Called by the view when it needs its `ListingViewModel`.
    func getListingViewModel() -> ListingViewModel
}

/// Delegates from the presenter (business rules) to the router (navigation)
protocol DetailPresenterToRouterProtocol: class {
    /// Creates the module.
    static func createModule(viewModel: ListingViewModel) -> UIViewController
}
