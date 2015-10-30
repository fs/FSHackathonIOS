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
    @IBOutlet var countLabel: WKInterfaceLabel!
    @IBOutlet var priceLabel: WKInterfaceLabel!
    
    @IBOutlet var tagGroup: WKInterfaceGroup!
    
    var element: Element?
    
    func prepareCell (element: Element) {
        self.titleLabel.setText(element.title)
        self.countLabel.setText("\(element.count) \(element.unit)")
        self.priceLabel.setText("\(element.minPrice) - \(element.maxPrice)")
        
//        self.tagGroup.setBackgroundColor(UIColor.blueColor())
    }
}

class ListController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    var list: List!
    
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
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func prepareCells () {
        self.table.setNumberOfRows(self.list.elements.count, withRowType: "ElementCell")
        
        for i in 0 ..< self.list.elements.count {
            let cell = self.table.rowControllerAtIndex(i) as! ElementCell
            cell.prepareCell(self.list.elements[i])
        }
    }
    
    override func contextForSegueWithIdentifier(segueIdentifier: String, inTable table: WKInterfaceTable, rowIndex: Int) -> AnyObject? {
        return self.list.elements[rowIndex]
    }
    
}
