//
//  DetailController.swift
//  Swift-Base
//
//  Created by Kruperfone on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import WatchKit
import Foundation

class DetailController: WKInterfaceController {
    
    @IBOutlet var productTitle: WKInterfaceLabel!
    @IBOutlet var productCategory: WKInterfaceLabel!
    @IBOutlet var productCount: WKInterfaceLabel!
    @IBOutlet var productPrice: WKInterfaceLabel!
    
    @IBOutlet var actionButton: WKInterfaceButton!
    
    var element: Element!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let element = context as? Element {
            self.element = element
        }
        
        self.prepareController()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func prepareController () {
        let object = self.element
        
        self.productTitle.setText(object.title)
        self.productCategory.setText("Овощи")
        self.productCount.setText("\(object.count) \(object.unit)")
        self.productPrice.setText("\(object.minPrice) - \(object.maxPrice)")
        
        self.updateButtonTitle()
    }
    
    func updateButtonTitle () {
        let buttonTitle = self.element.checked ? "Вернуть" : "Вычеркнуть"
        self.actionButton.setTitle(buttonTitle)
    }
    
    @IBAction func actionButtonTapped() {
        self.element.checked = !self.element.checked
        self.updateButtonTitle()
    }
}
