//
//  Device+CoreDataProperties.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 4/30/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import Foundation
import CoreData


extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    //@NSManaged public var device_id: Int32
    @NSManaged public var name: String?
    @NSManaged public var type: Int16
    @NSManaged public var buttons: NSSet?

}

// MARK: Generated accessors for buttons
extension Device {

    @objc(addButtonsObject:)
    @NSManaged public func addToButtons(_ value: Button)

    @objc(removeButtonsObject:)
    @NSManaged public func removeFromButtons(_ value: Button)

    @objc(addButtons:)
    @NSManaged public func addToButtons(_ values: NSSet)

    @objc(removeButtons:)
    @NSManaged public func removeFromButtons(_ values: NSSet)

}
