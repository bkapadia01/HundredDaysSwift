//
//  MenuGroups+CoreDataProperties.swift
//  tb-dev-challenge
//
//  Created by Bhavin Kapadia on 2022-03-29.
//
//

import Foundation
import CoreData

extension MenuGroups {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuGroups> {
        return NSFetchRequest<MenuGroups>(entityName: "MenuGroups")
    }

    @NSManaged public var menuImage: String?
    @NSManaged public var menuName: String?
    @NSManaged public var menuSet: Bool
    @NSManaged public var ofMenuItem: NSSet?

}

// MARK: Generated accessors for ofMenuItem
extension MenuGroups {

    @objc(addOfMenuItemObject:)
    @NSManaged public func addToOfMenuItem(_ value: MenuItems)

    @objc(removeOfMenuItemObject:)
    @NSManaged public func removeFromOfMenuItem(_ value: MenuItems)

    @objc(addOfMenuItem:)
    @NSManaged public func addToOfMenuItem(_ values: NSSet)

    @objc(removeOfMenuItem:)
    @NSManaged public func removeFromOfMenuItem(_ values: NSSet)

}

extension MenuGroups: Identifiable {

}
