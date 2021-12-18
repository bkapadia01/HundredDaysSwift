//
//  Person.swift
//  Project10
//
//  Created by Bhavin Kapadia on 2021-10-12.
//

import UIKit

class Person: NSObject, NSCoding {
    var name: String
    var image: String
    var nameSet: Bool
    
    init(name: String, image: String, nameSet: Bool) {
        self.name = name
        self.image = image
        self.nameSet = nameSet
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
        nameSet = aDecoder.decodeObject(forKey: "nameSet") as? Bool ?? false
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(nameSet, forKey: "nameSet")
    }
}
