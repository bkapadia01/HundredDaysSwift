//
//  Person.swift
//  Project10
//
//  Created by Bhavin Kapadia on 2021-10-12.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    var nameSet: Bool
    
    init(name: String, image: String, nameSet: Bool) {
        self.name = name
        self.image = image
        self.nameSet = nameSet
    }
}
