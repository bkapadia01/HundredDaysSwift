//
//  MenuItems+CoreDataClass.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-22.
//
//

import UIKit
import CoreData

@objc(MenuItem)
class MenuItem: NSManagedObject {

    convenience init?(itemImage: String?, itemName: String?, itemPrice: Double?, itemDateCreated: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate

        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }

        self.init(entity: MenuItem.entity(), insertInto: context)
        self.itemImage = itemImage
        self.itemName = itemName
        self.itemPrice = itemPrice!
        self.itemDateCreated = itemDateCreated
    }
}
