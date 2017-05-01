//
//  Button+CoreDataProperties.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 4/30/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import Foundation
import CoreData


extension Button {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Button> {
        return NSFetchRequest<Button>(entityName: "Button")
    }
    


    //@NSManaged public var button_id: Int32
    @NSManaged public var device_id: Int32
    @NSManaged public var ir_code: String?
    @NSManaged public var device: Device?
    
    
    @nonobjc public class func fetchAllRequest(_ device:Int32) -> NSFetchRequest<Button> {
        let fetchRequest = NSFetchRequest<Button>(entityName: "Button")
        
        fetchRequest.predicate = NSPredicate(format: "device_id == \(device)")//, 1)
        return fetchRequest
    }

}
