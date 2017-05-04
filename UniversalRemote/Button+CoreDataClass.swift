//
//  Button+CoreDataClass.swift
//  UniversalRemote
//
//  Created by Lisa Churchman on 4/30/17.
//  Copyright © 2017 CCB. All rights reserved.
//

import Foundation
import CoreData

@objc(Button)
public class Button: NSManagedObject {
    
    //fetch data for specific device
    func fetchAllButtonsForDevice(_ device: Int32) -> NSFetchRequest<Button> {
    //return NSFetchRequest<Button>(entityName: "Button")
        
        let fetchRequest = NSFetchRequest<Button>(entityName: "Button")
        
         fetchRequest.predicate = NSPredicate(format: "device_id == %@", device)
        return fetchRequest
    }

}
