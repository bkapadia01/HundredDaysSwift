//
//  Picture.swift
//  Project1
//
//  Created by Bhavin Kapadia on 2021-10-17.
//

import UIKit

class Picture: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
