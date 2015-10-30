//
//  DetailItemViewCell.swift
//  Swift-Base
//
//  Created by Nikita Fomin on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class DetailItemViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func prepareCell(list: List) {
//        if let date = order.createdAt {
//            self.nameLabel.text = OrdersHistoryCell.HistoryCellDateFormatter.stringFromDate(date)
//        }
//        
//        let orderedDishesArray = order.orderedDishes.array as! [SHOrderedDish]
//        var dishesString = ""
//        for i in 0 ..< orderedDishesArray.count {
//            if let lDish = orderedDishesArray[i].dish {
//                if let lDishTitle = lDish.title {
//                    if dishesString == "" {
//                        dishesString = lDishTitle
//                    } else {
//                        dishesString = [dishesString, lDishTitle].joinWithSeparator(", ")
//                    }
//                }
//            }
//        }
//        
//        dishesLabel.text = dishesString
//    }
    
}
