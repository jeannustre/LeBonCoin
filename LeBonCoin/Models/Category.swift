//
//  Category.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

struct Category: Codable {
    var id: Int
    var name: String?
    
    func color() -> UIColor? {
        return UIColor.init(named: "category-\(id)")
    }
    
}
