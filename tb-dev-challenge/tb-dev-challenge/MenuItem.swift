//
//  MenuItem.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-21.
//

import UIKit

class MenuItem: NSObject, Codable {
    
    var itemName: String
    var itemPrice: String
    var itemSet: Bool
    
    init(itemName: String, itemPrice: String, itemSet: Bool) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemSet = itemSet
    }
}
