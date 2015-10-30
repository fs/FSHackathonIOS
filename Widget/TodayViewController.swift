//
//  TodayViewController.swift
//  Widget
//
//  Created by Aynur Galiev on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit
import NotificationCenter

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

class TodayViewController: UIViewController, NCWidgetProviding {
    
    var lists: [List] = {
        var lists: [List] = []
        for i in 0 ..< 5 {
            var arr: [Element] = []
            for j in 0 ..< 10 {
                let value = Element(title: "Title \(i):\(j)", count: 5, unit: "гр.", minPrice: 5, maxPrice: 10)
                arr.append(value)
            }
            lists.append(List(title: "List \(i)", elements: arr))
        }
        
        return lists
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
    }
    
}
