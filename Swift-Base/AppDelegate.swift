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
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        self.setupMagicalRecords();
        self.fillDB()
        
        return true
    }
    
    func fillDB() {
        if Item.MR_findAll()!.count == 0 {
            
            //Фрукты
            let color1 = RandomColor().hexString()
            
            let item1 = Item.MR_createEntity()
            item1!.title = "Яблоки"
            item1!.category = "Фрукты"
            item1!.categoryColor = color1
            item1!.minPrice = NSNumber(float: 55.0)
            item1!.maxPrice = NSNumber(float: 71.0)
            
            let item2 = Item.MR_createEntity()
            item2!.title = "Виноград"
            item2!.category = "Фрукты"
            item2!.categoryColor = color1
            item2!.minPrice = NSNumber(float: 112.0)
            item2!.maxPrice = NSNumber(float: 144.0)
            
            let item3 = Item.MR_createEntity()
            item3!.title = "Персики"
            item3!.category = "Фрукты"
            item3!.categoryColor = color1
            item3!.minPrice = NSNumber(float: 81.0)
            item3!.maxPrice = NSNumber(float: 109.0)
            
            let item4 = Item.MR_createEntity()
            item4!.title = "Груши"
            item4!.category = "Фрукты"
            item4!.categoryColor = color1
            item4!.minPrice = NSNumber(float: 66.0)
            item4!.maxPrice = NSNumber(float: 79.0)
            
            //Овощи
            let color2 = RandomColor().hexString()
            
            let item5 = Item.MR_createEntity()
            item5!.title = "Помидоры"
            item5!.category = "Овощи"
            item5!.categoryColor = color2
            item5!.minPrice = NSNumber(float: 140.0)
            item5!.maxPrice = NSNumber(float: 155.0)
            
            let item6 = Item.MR_createEntity()
            item6!.title = "Огурцы"
            item6!.category = "Овощи"
            item6!.categoryColor = color2
            item6!.minPrice = NSNumber(float: 120.0)
            item6!.maxPrice = NSNumber(float: 132.0)
            
            //Яйца и молочные продукты
            let color3 = RandomColor().hexString()
            
            let item7 = Item.MR_createEntity()
            item7!.title = "Молоко"
            item7!.category = "Яйца и молочные продукты"
            item7!.categoryColor = color3
            item7!.minPrice = NSNumber(float: 29.0)
            item7!.maxPrice = NSNumber(float: 61.0)
            
            let item8 = Item.MR_createEntity()
            item8!.title = "Йогурт"
            item8!.category = "Яйца и молочные продукты"
            item8!.categoryColor = color3
            item8!.minPrice = NSNumber(float: 14)
            item8!.maxPrice = NSNumber(float: 29.0)
            
            
            let item9 = Item.MR_createEntity()
            item9!.title = "Кефир"
            item9!.category = "Яйца и молочные продукты"
            item9!.categoryColor = color3
            item9!.minPrice = NSNumber(float: 14.0)
            item9!.maxPrice = NSNumber(float: 27.0)
            
            let item10 = Item.MR_createEntity()
            item10!.title = "Катык"
            item10!.category = "Яйца и молочные продукты"
            item10!.categoryColor = color3
            item10!.minPrice = NSNumber(float: 15.0)
            item10!.maxPrice = NSNumber(float: 26.0)
            
            //Мука и мучные изделия
            let color4 = RandomColor().hexString()
            
            let item11 = Item.MR_createEntity()
            item11!.title = "Хлеб"
            item11!.category = "Мука и мучные изделия"
            item11!.categoryColor = color4
            item11!.minPrice = NSNumber(float: 15.0)
            item11!.maxPrice = NSNumber(float: 44.0)
            
            let item12 = Item.MR_createEntity()
            item12!.title = "Батон"
            item12!.category = "Мука и мучные изделия"
            item12!.categoryColor = color4
            item12!.minPrice = NSNumber(float: 15.0)
            item12!.maxPrice = NSNumber(float: 32.0)
            
            let item13 = Item.MR_createEntity()
            item13!.title = "Мука"
            item13!.category = "Мука и мучные изделия"
            item13!.categoryColor = color4
            item13!.minPrice = NSNumber(float: 56.0)
            item13!.maxPrice = NSNumber(float: 78.0)
            
            //Кондитерские изделия
            let color5 = RandomColor().hexString()
            
            let item14 = Item.MR_createEntity()
            item14!.title = "Шоколад"
            item14!.category = "Кондитерские изделия"
            item14!.categoryColor = color5
            item14!.minPrice = NSNumber(float: 56.0)
            item14!.maxPrice = NSNumber(float: 98.0)
            
            let item15 = Item.MR_createEntity()
            item15!.title = "Конфеты"
            item15!.category = "Кондитерские изделия"
            item15!.categoryColor = color5
            item15!.minPrice = NSNumber(float: 152.0)
            item15!.maxPrice = NSNumber(float: 389.0)
            
            let item16 = Item.MR_createEntity()
            item16!.title = "Торты"
            item16!.category = "Кондитерские изделия"
            item16!.categoryColor = color5
            item16!.minPrice = NSNumber(float: 120.0)
            item16!.maxPrice = NSNumber(float: 465.0)
            
            //Бакалея
            let color6 = RandomColor().hexString()
            
            let item17 = Item.MR_createEntity()
            item17!.title = "Мед"
            item17!.category = "Бакалея"
            item17!.categoryColor = color6
            item17!.minPrice = NSNumber(float: 205.0)
            item17!.maxPrice = NSNumber(float: 604.0)
            
            let item18 = Item.MR_createEntity()
            item18!.title = "Майонез"
            item18!.category = "Бакалея"
            item18!.categoryColor = color6
            item18!.minPrice = NSNumber(float: 27.0)
            item18!.maxPrice = NSNumber(float: 67.0)
            
            let item19 = Item.MR_createEntity()
            item19!.title = "Масло растительное"
            item19!.category = "Бакалея"
            item19!.categoryColor = color6
            item19!.minPrice = NSNumber(float: 51.0)
            item19!.maxPrice = NSNumber(float: 88.0)
            
            //Мясные продукты
            let color7 = RandomColor().hexString()
            
            let item20 = Item.MR_createEntity()
            item20!.title = "Колбаса"
            item20!.category = "Мясные продукты"
            item20!.categoryColor = color7
            item20!.minPrice = NSNumber(float: 154.0)
            item20!.maxPrice = NSNumber(float: 879.0)
            
            let item21 = Item.MR_createEntity()
            item21!.title = "Сосиски"
            item21!.category = "Мясные продукты"
            item21!.categoryColor = color7
            item21!.minPrice = NSNumber(float: 102.0)
            item21!.maxPrice = NSNumber(float: 165.0)
            
            let item22 = Item.MR_createEntity()
            item22!.title = "Сало"
            item22!.category = "Мясные продукты"
            item22!.categoryColor = color7
            item22!.minPrice = NSNumber(float: 77.0)
            item22!.maxPrice = NSNumber(float: 261.0)
            
            //Рыба
            let color8 = RandomColor().hexString()
            
            let item23 = Item.MR_createEntity()
            item23!.title = "Рыба соленая"
            item23!.category = "Рыба"
            item23!.categoryColor = color8
            item23!.minPrice = NSNumber(float: 155.0)
            item23!.maxPrice = NSNumber(float: 265.0)
            
            let item24 = Item.MR_createEntity()
            item24!.title = "Икра"
            item24!.category = "Рыба"
            item24!.categoryColor = color8
            item24!.minPrice = NSNumber(float: 402.0)
            item24!.maxPrice = NSNumber(float: 1230.0)
            
            
            //test lists
            for i in 0 ... 5 {
                let list = List.MR_createEntity()
                list!.title = "New List \(i + 1)"
                list!.date = NSDate()
                
                let listedItem1 = ListedItem.MR_createEntity()
                listedItem1!.count =  NSNumber(float: 2.0)
                listedItem1!.unit = Unit.Kilogramm.numberValue
                listedItem1!.item = item13;
                
                let listedItem2 = ListedItem.MR_createEntity()
                listedItem2!.count =  NSNumber(float: 2.0)
                listedItem2!.unit = Unit.Gramm.numberValue
                listedItem2!.item = item15;
                
                let listedItem3 = ListedItem.MR_createEntity()
                listedItem3!.count =  NSNumber(float: 2.0)
                listedItem3!.unit = Unit.Count.numberValue
                listedItem3!.item = item11;
                
                list!.listedItems = NSOrderedSet(array: [listedItem1!, listedItem2!, listedItem3!])
            }

            NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
        }
    }
    
}


//MARK: - Setup Services and Libraries
extension AppDelegate {
    private func setupMagicalRecords () {
        MagicalRecord.setupCoreDataStackWithStoreNamed("DataBase")
        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
        MagicalRecord.setupAutoMigratingCoreDataStack()
        MagicalRecord.setLoggingLevel(.Off)
    }
}