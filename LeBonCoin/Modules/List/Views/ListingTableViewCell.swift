//
//  ListingTableViewCell.swift
//  LeBonCoin
//
//  Created by Jean Sarda on 13/10/2020.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    static let tableViewReuseIdentifier: String = "listingTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .red
    }

}
