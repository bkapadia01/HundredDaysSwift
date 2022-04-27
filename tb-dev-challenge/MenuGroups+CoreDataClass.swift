//
//  MenuGroups+CoreDataClass.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-22.
//
//

import UIKit
import CoreData

@objc(MenuGroups)
class MenuGroups: NSManagedObject {
    var menuItems: [MenuItem]? {
        return self.ofMenuItem?.allObjects as? [MenuItem]
    }
}
