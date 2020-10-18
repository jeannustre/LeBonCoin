//
//  FilterButton.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 15/10/2020.
//

import UIKit

/// The delegate protocol for the `FilterButton`.
protocol FilterButtonDelegate: class {
    /// Called by the button when a category has been selected.
    func filterButton(filterButton: FilterButton, didSelectCategory category: Category?)
    /// Called by the button when a controller should be presented.
    func filterButton(filterButton: FilterButton, asksToPresentAlertController controller: UIAlertController)
    /// Called by the button when no cagegory has been selected.
    func filterButtonDidSelectAllCategories(filterButton: FilterButton)
}

/// The button used in the navigation bar to filter content in the main list.
class FilterButton: UIBarButtonItem {
    /// The delegate for the `FilterButton`.
    weak var delegate: FilterButtonDelegate?
    /// The current available categories.
    private var categories: [Category]
    
    /// Initializes from a list of categories.
    init(categories: [Category]) {
        self.categories = categories
        super.init()
        self.action = #selector(tappedSortButton)
        self.image = UIImage(named: "navbar-filter-button")
        self.accessibilityIdentifier = "filter-button"
    }
    
    /// Updates the list of categories.
    func updateCategories(_ categories: [Category]) {
        self.categories = categories
    }
    
    /// Called when the button has been tapped and the action sheet should be presented.
    @objc func tappedSortButton() {
        let actionSheet = UIAlertController(title: "Quelle catégorie voulez-vous consulter ?", message: nil, preferredStyle: .actionSheet)
        let allAction = UIAlertAction(title: "Toutes", style: .cancel, handler: { action in
            self.delegate?.filterButtonDidSelectAllCategories(filterButton: self)
        })
        actionSheet.addAction(allAction)
        for category in categories {
            let categoryAction = UIAlertAction(title: category.name, style: .default, handler: { action in
                self.delegate?.filterButton(filterButton: self, didSelectCategory: category)
            })
            actionSheet.addAction(categoryAction)
        }
        delegate?.filterButton(filterButton: self, asksToPresentAlertController: actionSheet)
    }
    
    /// IB bad
    required init?(coder: NSCoder) {
        fatalError("👎")
    }
    
}
