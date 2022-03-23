//
//  MenuGroupModel.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-19.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//Model file
//   let menuGroup = try? newJSONDecoder().decode(MenuGroup.self, from: jsonData)
//composed method 
import UIKit

// MARK: - MenuGroupElement
class MenuGroupElement: NSObject, Codable {
    var menuGroupName: String
    var menuGroupImage: String
    var menuGroupSet: Bool
    var menuItems: [MenuItem]

    init(menuGroupName: String, menuGroupImage: String, menuGroupSet: Bool, menuItems: [MenuItem]) {
        self.menuGroupName = menuGroupName
        self.menuGroupImage = menuGroupImage
        self.menuGroupSet = menuGroupSet
        self.menuItems = menuItems
    }
}

// MARK: - MenuItem
class MenuItem: NSObject, Codable {
    var itemName: String?
    var itemPrice: String?
    var itemImage: String?
    init(itemName: String, itemPrice: String, itemImage: String) {
        self.itemName = itemName
        self.itemPrice = itemPrice
        self.itemImage = itemImage
    }
}
