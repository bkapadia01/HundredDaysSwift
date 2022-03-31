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
public class MenuGroups: NSManagedObject {
    var menuItems: [MenuItems]? {
        return self.ofMenuItem?.allObjects as? [MenuItems]
    }
}
