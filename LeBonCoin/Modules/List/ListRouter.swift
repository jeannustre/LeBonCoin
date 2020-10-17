//
//  ListRouter.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

/// The router for the List module.
final class ListRouter: ListPresenterToRouterProtocol {
    
    /// Initializes and returns the whole module.
    /// - Returns: a `ListViewController`.
    static func createModule() -> ListViewController {
        // Change to get view from storyboard if not using progammatic UI
        // swiftlint:disable force_cast
        let view = ListViewController()
        // swiftlint:enable force_cast
        let interactor: ListPresenterToInteractorProtocol = ListInteractor()
        let router: ListPresenterToRouterProtocol = ListRouter()
        let presenter: ListViewToPresenterProtocol & ListInteractorToPresenterProtocol = ListPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }

    /// Starts navigation to the Listing Detail page.
    func navigateToDetail(from view: ListPresenterToViewProtocol?, with listing: ListingViewModel) {
        let detailVC = DetailRouter.createModule(viewModel: listing)
        view?.presentController(detailVC)
    }
    
}

