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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(listedItem: ListedItem) {
        self.customImageView.image = UIImage(named: (listedItem.item?.title)!)
        self.titleLabel.text = listedItem.item?.title
        
        // detail
        let count = "\((listedItem.count?.doubleValue)!) \(listedItem.unit)"
        let price = "\((listedItem.count?.doubleValue)! * (listedItem.item?.minPrice?.doubleValue)!)"
        self.detailLabel.text = "Количество: \(count), примерная стоимость: \(price)"
    }
    
}
