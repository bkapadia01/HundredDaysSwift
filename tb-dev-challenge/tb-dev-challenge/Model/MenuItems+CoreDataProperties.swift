//
//  MenuItems+CoreDataProperties.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-04-01.
//
//

import Foundation
import CoreData

extension MenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItem> {
        return NSFetchRequest<MenuItem>(entityName: "MenuItem")
    }

    @NSManaged public var itemImage: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemPrice: Double
    @NSManaged public var itemDateCreated: Date?
    @NSManaged public var ofMenuGroup: MenuGroups?

}

extension MenuItem: Identifiable {

}
