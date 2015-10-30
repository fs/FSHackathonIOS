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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkbox = M13Checkbox(frame: self.checkboxView.bounds)
        self.checkboxView.addSubview(self.checkbox)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(listedItem: ListedItem) {
        self.customImageView.image = UIImage(named: (listedItem.item?.title)!)
        self.titleLabel.text = listedItem.item?.title
        
        // checkbox
//        self.checkbox.checkState = listedItem.selected.boolValue ? M13CheckboxStateChecked : M13CheckboxStateUnchecked
        
        // detail
        let count = "\((listedItem.count?.doubleValue)!) \(listedItem.unit)"
        let price = "\((listedItem.count?.doubleValue)! * (listedItem.item?.minPrice?.doubleValue)!)"
        self.detailLabel.text = "Количество: \(count), примерная стоимость: \(price)"
    }
    
}
