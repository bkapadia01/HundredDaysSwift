//
//  Pictures.swift
//  Project10_3a
//
//  Created by Bhavin Kapadia on 2021-11-06.
//

import UIKit

class Pictures: NSObject {
    var name: String
    var image: String

    init(name: String, image: String, nameSet: Bool) {
        self.name = name
        self.image = image
    }
}
