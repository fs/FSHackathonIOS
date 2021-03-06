//
//  TodayViewController.swift
//  Widget
//
//  Created by Aynur Galiev on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit
import NotificationCenter

//class Element {
//    let title: String
//    
//    let count: Int
//    let unit: String
//    
//    let minPrice: Double
//    let maxPrice: Double
//    
//    var checked: Bool = false
//    
//    var categoryColor = RandomColor()
//    
//    init (title: String, count: Int, unit: String, minPrice: Double, maxPrice: Double) {
//        self.title = title
//        self.count = count
//        self.unit = unit
//        self.minPrice = minPrice
//        self.maxPrice = maxPrice
//    }
//}

//class List {
//    let title: String
//    var elements: [Element]
//    
//    var completed = false
//    
//    init (title: String, elements: [Element]) {
//        self.title = title
//        self.elements = elements
//    }
//    
//    var uncheckedElements: [Element] {
//        let values = self.elements.filter { (value: Element) -> Bool in
//            return !value.checked
//        }
//        return values
//    }
//    
//    var checkedElements: [Element] {
//        let values = self.elements.filter { (value: Element) -> Bool in
//            return value.checked
//        }
//        return values
//    }
//    
//    var minPrice: Double {
//        var value: Double = 0
//        for element in self.elements {
//            value += element.minPrice
//        }
//        return value
//    }
//    
//    var maxPrice: Double {
//        var value: Double = 0
//        for element in self.elements {
//            value += element.maxPrice
//        }
//        return value
//    }
//}

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var lists: [List] = []
    
    private var _currentIndex: Int = 0
    var currentIndex: Int {
        
        set (value) {
            if value >= self.lists.count {
                self._currentIndex = 0
            } else {
                self._currentIndex = value
            }
            self.reloadData()
        }
        
        get {
            return self._currentIndex
        }
    }
    
    var currentList: List? {
        guard self.lists.count > 0 else {return nil}
        return self.lists[self.currentIndex]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupMagicalRecords()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lists = self.getLists()
        self.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupMagicalRecords () {
        MagicalRecord.setupCoreDataStackWithStoreNamed("DataBase")
//        MagicalRecord.setShouldDeleteStoreOnModelMismatch(true)
//        MagicalRecord.setupAutoMigratingCoreDataStack()
        MagicalRecord.setLoggingLevel(.Off)
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func getLists () -> [List] {
        let lists = List.MR_findAllSortedBy("date", ascending: true) as! [List]
        return lists
    }
    
    func reloadData () {
        if let list = self.currentList {
            self.listTitleLabel.text = list.title
            self.priceLabel.text = "От \(list.minPrice) до \(list.maxPrice) рублей"
        }
        
        self.tableView.reloadData()
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData

        completionHandler(NCUpdateResult.NewData)
        self.lists = self.getLists()
        self.currentIndex = 0
    }
    
    @IBAction func tappedInView(sender: AnyObject) {
        self.currentIndex++
    }
    
    @IBAction func upButtonTapped(sender: AnyObject) {
        let cells = self.tableView.visibleCells
        guard let first = cells.first else {return}
        
        var toIndex = first.tag - 3
        toIndex = toIndex >= 0 ? toIndex : 0
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: toIndex, inSection: 0), atScrollPosition: .Top, animated: true)
    }
    
    @IBAction func downButtonTapped(sender: AnyObject) {
        let cells = self.tableView.visibleCells
        guard let last = cells.last else {return}
        guard let list = self.currentList else {return}
        
        var toIndex = last.tag + 3
        toIndex = toIndex < list.listedItems.count ? toIndex : list.listedItems.count - 1
        
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: toIndex, inSection: 0), atScrollPosition: .Top, animated: true)
    }
}

extension TodayViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = self.currentList else {return 0}
        return list.listedItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TodayCell") as! TodayCell
        cell.prepareCell(self.currentList!.listedItems[indexPath.row] as! ListedItem)
        cell.tag = indexPath.row
        return cell
    }
}
