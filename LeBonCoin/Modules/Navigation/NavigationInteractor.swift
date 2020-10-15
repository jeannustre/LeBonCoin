//
//  NavigationInteractor.swift
//  LeBonCoin
//
//  Created Jean Sarda on 15/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

/// The interactor for the Navigation module.
final class NavigationInteractor: NavigationPresenterToInteractorProtocol {

    /// Reference to the module's presenter.
    weak var presenter: NavigationInteractorToPresenterProtocol?
}
