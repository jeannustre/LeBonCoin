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
    
    /// Fetches the listings.
    func getListings() {
        if CommandLine.arguments.contains("--uitesting") {
            presenter?.getListingsSuccess(response: loadMockListings())
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
                self?.presenter?.getListingsSuccess(response: self?.loadMockListings() ?? [])
            })
        }
    }
    
    /// Fetches categories.
    func getCategories() {
        if CommandLine.arguments.contains("--uitesting") {
            presenter?.getCategoriesSuccess(response: loadMockCategories())
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
                self?.presenter?.getCategoriesSuccess(response: self?.loadMockCategories() ?? [])
            })
        }
    }
    
    private func loadMockListings() -> [Listing] {
        let url = Bundle.main.url(forResource: "TestData", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode([Listing].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
    private func loadMockCategories() -> [Category] {
        let url = Bundle.main.url(forResource: "TestCategories", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Category].self, from: data)
            return decoded
        } catch {
            return []
        }
    }
    
}
