//
//  DetailItemViewCell.swift
//  Swift-Base
//
//  Created by Nikita Fomin on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class DetailItemViewCell: UITableViewCell {

    @IBOutlet weak var customImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var checkboxView: UIView!
    
    var checkbox: M13Checkbox!
    weak var listedItem: ListedItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkbox = M13Checkbox(frame: self.checkboxView.bounds)
        self.checkbox.addTarget(self, action: "checkboxTapped", forControlEvents: UIControlEvents.TouchUpInside)
        self.checkboxView.addSubview(self.checkbox)
        
        self.customImageView.layer.cornerRadius = self.customImageView.bounds.width * 0.5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkbox.checkState = M13CheckboxStateUnchecked
        self.customImageView.image = nil
        self.listedItem = nil
    }
    
    func prepareCell(listedItem: ListedItem) {
        
        self.listedItem = listedItem
        
        self.customImageView.image = UIImage(named: "\(listedItem.item!.title!).jpg")
        self.titleLabel.text = listedItem.item!.title
        
        // checkbox
        self.checkbox.checkState = listedItem.selected!.boolValue ? M13CheckboxStateChecked : M13CheckboxStateUnchecked
        
        // detail
        let count = "\((listedItem.count?.doubleValue)!) \(Unit.init(intValue: Int16(listedItem.unit!.integerValue))!.short)"
        let price = "\((listedItem.count?.doubleValue)! * (listedItem.item?.minPrice?.doubleValue)!)"
        self.detailLabel.text = "Количество: \(count), \nПримерная стоимость: \(price)"
    }
    
    func checkboxTapped() {
        let isSelected = self.checkbox.checkState == M13CheckboxStateChecked
        self.listedItem?.selected = NSNumber(bool: isSelected)
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
    
}
