//
//  MenuItems+CoreDataClass.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-22.
//
//

import UIKit
import CoreData

@objc(MenuItems)
public class MenuItems: NSManagedObject {

    // Review: Using convenience to make use of init much simpler and can use self instead of super
    convenience init?(itemImage: String?, itemName: String?, itemPrice: Double?, itemDateCreated: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }

        self.init(entity: MenuItems.entity(), insertInto: context)
        self.itemImage = itemImage
        self.itemName = itemName
        self.itemPrice = itemPrice!
        self.itemDateCreated = itemDateCreated
    }
}
