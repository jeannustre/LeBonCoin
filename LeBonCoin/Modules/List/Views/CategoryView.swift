//
//  CategoryView.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 14/10/2020.
//

import UIKit

class CategoryView: UIView {
    
    var category: Category? {
        didSet {
            categoryLabel.text = category?.name
            backgroundColor = category?.color()
        }
    }
    
    private lazy var categoryLabel: UILabel = {
        let categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textColor = NamedColors.leBonConstrast
        categoryLabel.textAlignment = .left
        categoryLabel.font = DMSansFont.regular.font(size: 16)
        return categoryLabel
    }()
    
    init(category: Category?) {
        super.init(frame: CGRect.zero)
        backgroundColor = .cyan
        addSubview(categoryLabel)
        categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        self.category = category
        layer.masksToBounds = false
        layer.cornerRadius = 10
        if #available(iOS 13.0, *) {
            layer.cornerCurve = .continuous
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("👎")
    }
    
}

