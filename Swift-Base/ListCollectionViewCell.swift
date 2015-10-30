//
//  ListCollectionViewCell.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - UI
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - params
    private(set) var list: List! = nil {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
        self.list = nil
    }
    
    func prepareCell(list: List) {
        self.nameLabel.text = list.title
        self.list = list
    }
}

//MARK: - UITableViewDelegate
extension ListCollectionViewCell: UITableViewDelegate {
    
    //MARK: Cells
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
}

//MARK: - UITableViewDataSource
extension ListCollectionViewCell: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.listedItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailItemViewCell") as! DetailItemViewCell
        //        let item = self.list.listedItem.count as! ListedItam
        //        cell.prepareCell(item)
        return cell
    }
    
}