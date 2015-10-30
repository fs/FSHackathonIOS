//
//  TodayCell.swift
//  Swift-Base
//
//  Created by Kruperfone on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class TodayCell: UITableViewCell {
    
    @IBOutlet weak var checkbox: M13Checkbox!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell (element: Element) {
        self.titleLabel.text = element.title
    }

}
