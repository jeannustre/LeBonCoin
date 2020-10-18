//
//  NavigationViewController.swift
//  LeBonCoin
//
//  Created Jean Sarda on 15/10/2020.
//  Copyright © 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// The Navigation view controller. Subclass of UIViewController.
class NavigationViewController: UINavigationController {

    // MARK: - Public Properties

    /// A reference to the view's presenter.
	var presenter: NavigationViewToPresenterProtocol?

    // MARK: - Initializer

    /// Initializer
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Initializer required
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

/// An extension of the Navigation view controller, used to get info back from the Presenter.
extension NavigationViewController: NavigationPresenterToViewProtocol {
    
}
