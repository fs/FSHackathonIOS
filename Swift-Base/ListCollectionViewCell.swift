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
    @IBOutlet weak var addItemButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        
        self.tableView.estimatedRowHeight = 90
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
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
}

//MARK: - UITableViewDataSource
extension ListCollectionViewCell: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list?.listedItem.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailItemViewCell") as! DetailItemViewCell
        let item = self.list.listedItem.allObjects[indexPath.row] as! ListedItem
        cell.prepareCell(item)
        return cell
    }
    
}