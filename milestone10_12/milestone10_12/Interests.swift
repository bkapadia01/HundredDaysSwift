//
//  Interests.swift
//  milestone10_12
//
//  Created by Bhavin Kapadia on 2021-12-26.
//

import UIKit

class Interests: NSObject, NSCoding {

    
    var interestingTitle: String
    var interestingCaption: String
    var interestingImagePath: String
    
    init(interestingTitle: String, interestingCaption: String, interestingImagePath: String) {
        self.interestingTitle = interestingTitle
        self.interestingCaption = interestingCaption
        self.interestingImagePath = interestingImagePath
    }
    
    required init?(coder: NSCoder) {
        interestingTitle = coder.decodeObject(forKey: "interestingTitle") as? String ?? ""
        interestingCaption = coder.decodeObject(forKey: "interestingCaption") as? String ?? ""
        interestingImagePath = coder.decodeObject(forKey: "interestingImagePath") as? String ?? ""
    }
    func encode(with coder: NSCoder) {
        coder.encode(interestingTitle, forKey: "interestingTitle")
        coder.encode(interestingCaption, forKey: "interestingCaption")
        coder.encode(interestingImagePath, forKey: "interestingImagePath")
    }
}

