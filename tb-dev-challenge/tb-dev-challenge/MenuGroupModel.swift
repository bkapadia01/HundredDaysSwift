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

import UIKit

// MARK: - MenuGroupElement
class MenuGroupElement: NSObject, Codable {
    var menuName: String
    var image: String
    var menuSet: Bool
    var menuItems: [MenuItem]

    init(menuName: String, image: String, menuSet: Bool, menuItem: [MenuItem]) {
        self.menuName = menuName
        self.image = image
        self.menuSet = menuSet
        self.menuItems = menuItem
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
