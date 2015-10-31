//
//  InterfaceController.swift
//  watch Extension
//
//  Created by Kruperfone on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import WatchKit
import Foundation

class Element {
    let title: String
    let category: String
    
    let count: Int
    let unit: String
    
    let minPrice: Double
    let maxPrice: Double
    
    var checked: Bool = false
    
    let categoryColor: UIColor
    
    init (title: String, category: (name: String, color: UIColor), count: Int, unit: String, minPrice: Double, maxPrice: Double) {
        self.title = title
        self.category = category.name
        self.categoryColor = category.color
        self.count = count
        self.unit = unit
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}

class List {
    let title: String
    let elements: [Element]
    
    var completed = false
    
    init (title: String, elements: [Element]) {
        self.title = title
        self.elements = elements
    }
    
    var uncheckedElements: [Element] {
        let values = self.elements.filter { (value: Element) -> Bool in
            return !value.checked
        }
        return values
    }
    
    var checkedElements: [Element] {
        let values = self.elements.filter { (value: Element) -> Bool in
            return value.checked
        }
        return values
    }
    
    var minPrice: Double {
        var value: Double = 0
        for element in self.elements {
            value += element.minPrice
        }
        return value
    }
    
    var maxPrice: Double {
        var value: Double = 0
        for element in self.elements {
            value += element.maxPrice
        }
        return value
    }
}

class ListCell: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var priceLabel: WKInterfaceLabel!
    
    func prepareCell (list: List) {
        self.titleLabel.setText(list.title)
        self.priceLabel.setText("\(Int(list.minPrice)) - \(Int(list.maxPrice)) рублей")
        
        let color = list.completed ? UIColor.lightGrayColor() : UIColor.whiteColor()
        
        self.titleLabel.setTextColor(color)
        self.priceLabel.setTextColor(color)
    }
}

class ListsController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    var lists: [List] = []

    var showCompleted = true
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.lists = self.createLists()
        
        self.prepareCells()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.prepareCells()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func prepareCells () {
        
        let objects = self.lists.filter {[weak self] (value: List) -> Bool in
            guard let sself = self else {return false}
            return !value.completed || sself.showCompleted
        }
        
        self.table.setNumberOfRows(objects.count, withRowType: "ListCell")
        
        for i in 0 ..< objects.count {
            let cell = self.table.rowControllerAtIndex(i) as! ListCell
            cell.prepareCell(objects[i])
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let list = self.lists[rowIndex]
        return list
    }
    @IBAction func unhideCompleted() {
        self.showCompleted = true
        self.prepareCells()
    }
    
    @IBAction func hideCompleted() {
        self.showCompleted = false
        self.prepareCells()
    }
    
    func createLists () -> [List] {
        
        var categories: [(name: String, color: UIColor)] = []
        
        categories.append((name: "Молочные продукты", color: UIColor.blueColor()))
        categories.append((name: "Мясо", color: UIColor.redColor()))
        categories.append((name: "Фрукты", color: UIColor.yellowColor()))
        categories.append((name: "Кондитерские изделия", color: UIColor.purpleColor()))
        
        var items: [Element] = []
        
        items.append(Element(title: "Молоко", category: categories[0], count: 2, unit: "л", minPrice: 30, maxPrice: 60))
        items.append(Element(title: "Кефир", category: categories[0], count: 2, unit: "л", minPrice: 30, maxPrice: 50))
        
        items.append(Element(title: "Колбаса", category: categories[1], count: 1, unit: "кг", minPrice: 200, maxPrice: 300))
        items.append(Element(title: "Котлеты", category: categories[1], count: 2, unit: "кг", minPrice: 200, maxPrice: 250))
        
        items.append(Element(title: "Яблоки", category: categories[2], count: 5, unit: "шт", minPrice: 15, maxPrice: 20))
        items.append(Element(title: "Апельсины", category: categories[2], count: 3, unit: "шт", minPrice: 20, maxPrice: 25))
        
        items.append(Element(title: "Конфеты", category: categories[3], count: 1, unit: "кг", minPrice: 200, maxPrice: 300))
        items.append(Element(title: "Мороженое", category: categories[3], count: 2, unit: "шт", minPrice: 50, maxPrice: 70))
        
        var lists: [List] = []
        for _ in 0 ..< 5 {
            lists.append(List(title: "Покупки", elements: items))
        }
        
        return lists
    }
}

func RandomColor () -> UIColor {
    let red     = CGFloat(arc4random_uniform(255))/255.0
    let green   = CGFloat(arc4random_uniform(255))/255.0
    let blue    = CGFloat(arc4random_uniform(255))/255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}
