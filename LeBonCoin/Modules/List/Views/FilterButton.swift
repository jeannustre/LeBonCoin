//
//  FilterButton.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 15/10/2020.
//

import UIKit

protocol FilterButtonDelegate: class {
    func filterButton(filterButton: FilterButton, didSelectCategory category: Category?)
    func filterButton(filterButton: FilterButton, asksToPresentAlertController controller: UIAlertController)
    func filterButtonDidSelectAllCategories(filterButton: FilterButton)
}

class FilterButton: UIBarButtonItem {

    weak var delegate: FilterButtonDelegate?
    private var categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
        super.init()
        self.action = #selector(tappedSortButton)
        self.image = UIImage(named: "navbar-filter-button")
        self.accessibilityIdentifier = "filter-button"
    }
    
    func updateCategories(_ categories: [Category]) {
        self.categories = categories
    }
    
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
    
    required init?(coder: NSCoder) {
        fatalError("👎")
    }
    
}
