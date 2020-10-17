//
//  DetailRouter.swift
//  LeBonCoin
//
//  Created Jean Sarda on 17/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// The router for the Detail module.
class DetailRouter: DetailPresenterToRouterProtocol {
    
    /// Initializes and returns the whole module.
    /// - Returns: a `DetailViewController`.
    static func createModule(viewModel: ListingViewModel) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        // swiftlint:disable force_cast
        let view = DetailViewController()
        // swiftlint:enable force_cast
        let interactor: DetailPresenterToInteractorProtocol = DetailInteractor()
        let router: DetailPresenterToRouterProtocol = DetailRouter()
        let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = DetailPresenter(view: view, interactor: interactor, router: router, viewModel: viewModel)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
}
