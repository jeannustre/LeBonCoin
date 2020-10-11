//
//  ListInteractor.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 11/10/2020.
//

import Foundation

/// The interactor for the List module.
final class ListInteractor: ListPresenterToInteractorProtocol {

    /// Reference to the module's presenter.
    weak var presenter: ListInteractorToPresenterProtocol?

    /// The sign in function.
    /// - Parameter object: the `ListingsRequest` object to use for getting the listings. In this small app it's empty since the route is static :) 
    func getListings(object: ListingsRequest) {
        
    }
    
}
