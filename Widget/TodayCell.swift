//
//  TodayCell.swift
//  Swift-Base
//
//  Created by Kruperfone on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class TodayCell: UITableViewCell {
    
    @IBOutlet weak var checkboxContainer: UIView! {
        didSet (value) {
            let checkbox = M13Checkbox(frame: self.checkboxContainer.bounds)
            checkbox.translatesAutoresizingMaskIntoConstraints = false
            self.checkboxContainer.addSubview(checkbox)
            checkbox.addConstraints(FSSizeConstraints(checkbox, size: checkboxContainer.frame.size))
            self.checkboxContainer.addConstraints(FSCenterConstraints(checkbox))
            
            checkbox.radius = checkbox.frame.width/2
            
            self.checkbox = checkbox
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    
    var checkbox: M13Checkbox!
    
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
        self.checkbox.checkState = M13CheckboxStateUnchecked
    }

}
