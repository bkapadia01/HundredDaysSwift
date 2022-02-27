//
//  Menu.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-02-19.
//

import UIKit

class Menu: NSObject, Codable {
    var menuName: String
    var image: String
    var menuSet: Bool
    
    init(menuName: String, image: String, menuSet: Bool) {
        self.menuName = menuName
        self.image = image
        self.menuSet = menuSet
    }

}
