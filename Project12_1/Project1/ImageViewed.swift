//
//  ImageViewed.swift
//  Project1
//
//  Created by Bhavin Kapadia on 2021-12-18.
//

import UIKit

class imageviewed: NSObject, Codable {
    var viewed: Int
    
    init(viewed: Int) {
        self.viewed = viewed
    }
}
