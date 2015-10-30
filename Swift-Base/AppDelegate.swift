//
//  AppDelegate.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit
import CoreData
import Crashlytics

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.setupLibraries()
        
        for i in 0 ... 5 {
            let list = List.MR_createEntityInContext(NSManagedObjectContext.MR_defaultContext())
            list.title = "Test \(i + 1)"
        }
        
        return true
    }

}

//MARK: - Setup Services and Libraries
extension AppDelegate {
    private func setupLibraries () {
        //Setting MagicalRecord
        self.setupMagicalRecords()
    }
    
    private func setupMagicalRecords () {
        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
        MagicalRecord.setupAutoMigratingCoreDataStack()
        MagicalRecord.setLoggingLevel(.Off)
    }
}

