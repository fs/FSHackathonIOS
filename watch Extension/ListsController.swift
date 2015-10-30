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
    
    let count: Int
    let unit: String
    
    let minPrice: Double
    let maxPrice: Double
    
    var checked: Bool = false
    
    var categoryColor = RandomColor()
    
    init (title: String, count: Int, unit: String, minPrice: Double, maxPrice: Double) {
        self.title = title
        self.count = count
        self.unit = unit
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}

class List {
    let title: String
    let elements: [Element]
    
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
}

class ListCell: NSObject {
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var countLabel: WKInterfaceLabel!
    
    func prepareCell (list: List) {
        self.titleLabel.setText(list.title)
        self.countLabel.setText("\(list.elements.count)")
    }
}

class ListsController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    var lists: [List] = []

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        for i in 0 ..< 5 {
            var arr: [Element] = []
            for j in 0 ..< 10 {
                let value = Element(title: "Title \(i):\(j)", count: 5, unit: "гр.", minPrice: 5, maxPrice: 10)
                arr.append(value)
            }
            self.lists.append(List(title: "List \(i)", elements: arr))
        }
        
        self.prepareCells()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func prepareCells () {
        self.table.setNumberOfRows(self.lists.count, withRowType: "ListCell")
        
        for i in 0 ..< self.lists.count {
            let cell = self.table.rowControllerAtIndex(i) as! ListCell
            cell.prepareCell(self.lists[i])
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        let list = self.lists[rowIndex]
        return list
    }
}

func RandomColor () -> UIColor {
    let red     = CGFloat(arc4random_uniform(255))/255.0
    let green   = CGFloat(arc4random_uniform(255))/255.0
    let blue    = CGFloat(arc4random_uniform(255))/255.0
    
    return UIColor(red: red, green: green, blue: blue, alpha: 1)
}
