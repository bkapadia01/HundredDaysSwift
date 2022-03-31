//
//  MenuItems+CoreDataProperties.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-29.
//
//

import Foundation
import CoreData

extension MenuItems {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItems> {
        return NSFetchRequest<MenuItems>(entityName: "MenuItems")
    }

    @NSManaged public var itemImage: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Double
    @NSManaged public var ofMenuGroup: MenuGroups?

}

extension MenuItems: Identifiable {

}
