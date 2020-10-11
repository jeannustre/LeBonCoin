//
//  ViewController.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import UIKit

class ListViewController: UIViewController {
    
    var presenter: ListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Please initialize ListViewController programatically only")
    }

}

/// An extension of the List view controller, used to get info back from the Presenter.
extension ListViewController: ListPresenterToViewProtocol {
 
    /// Called by the presenter when listings have been fetched.
    func gotListings() {

    }
    
    /// Called by the presenter when listings couldn't be fetched.
    func getListingsError() {
        
    }
    
}
