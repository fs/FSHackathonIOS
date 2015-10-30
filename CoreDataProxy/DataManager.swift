//
//  DataManager.swift
//  Swift-Base
//
//  Created by Aynur Galiev on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import CoreData

public class DataManager: NSObject {
    
    public class func getContext() -> NSManagedObjectContext {
        return WatchCoreDataProxy.sharedInstance.managedObjectContext!
    }
    
    public class func deleteManagedObject(object:NSManagedObject) {
        getContext().deleteObject(object)
        saveManagedContext()
    }
    
    public class func saveManagedContext() {
        var error : NSError? = nil
        
        do {
            try self.getContext().save()
        } catch let error as NSError {
            NSLog("Unresolved error saving context \(error), \(error.userInfo)")
            abort()
        }
    }
    
}
