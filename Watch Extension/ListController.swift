//
//  ListController.swift
//  Swift-Base
//
//  Created by Kruperfone on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import WatchKit
import Foundation

class ElementCell: NSObject {
    
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var priceLabel: WKInterfaceLabel!
    
    @IBOutlet var tagGroup: WKInterfaceGroup!
    
    var element: Element?
    
    func prepareCell (element: Element) {
        self.titleLabel.setText(element.title)
        let middle = (element.maxPrice + element.minPrice)/2
        self.priceLabel.setText("\(element.count) x \(middle)")
        
        let color = element.checked ? UIColor.lightGrayColor() : UIColor.whiteColor()
        self.titleLabel.setTextColor(color)
        self.priceLabel.setTextColor(color)
        
        self.tagGroup.setBackgroundColor(element.categoryColor)
    }
}

class ListController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    var list: List!
    
    var showChecked = false
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let list = context as? List {
            self.list = list
        }
        
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
        
        let objects = self.showChecked ? self.list.elements : self.list.uncheckedElements
        
        self.table.setNumberOfRows(objects.count, withRowType: "ElementCell")
        
        for i in 0 ..< objects.count {
            let cell = self.table.rowControllerAtIndex(i) as! ElementCell
            cell.prepareCell(objects[i])
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return self.list.elements[rowIndex]
    }
    
    @IBAction func unhideCompleted() {
        self.showChecked = true
        self.prepareCells()
    }
    
    @IBAction func hideCompleted() {
        self.showChecked = false
        self.prepareCells()
    }
    
    @IBAction func restoreAll() {
        for object in self.list.elements {
            object.checked = false
        }
        
        self.list.completed = false
        
        self.prepareCells()
    }
    @IBAction func doneAction() {
        for object in self.list.elements {
            object.checked = true
        }
        
        self.list.completed = true
        
        self.prepareCells()
    }
}
