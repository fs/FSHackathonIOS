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
            checkbox.tintColor = UIColor.clearColor()
            
            checkbox.userInteractionEnabled = false
            
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
    
    weak var element: ListedItem?
    
    func prepareCell (element: ListedItem) {
        self.element = element
        
        self.titleLabel.text = element.item!.title
        self.checkbox.checkState = element.selected!.boolValue ? M13CheckboxStateChecked : M13CheckboxStateUnchecked
        
        self.checkbox.strokeColor = element.item!.color
        self.checkbox.checkColor = element.item!.color
    }
    
    @IBAction func checkboxTapped (sender: AnyObject?) {
        guard let checkbox = self.checkbox else {return}
        
        var value = false
        
        switch checkbox.checkState {
        case M13CheckboxStateUnchecked:
            checkbox.checkState = M13CheckboxStateChecked
            value = true
            
        case M13CheckboxStateChecked:
            checkbox.checkState = M13CheckboxStateUnchecked
            value = false
            
        case M13CheckboxStateMixed:
            checkbox.checkState = M13CheckboxStateChecked
             value = true
            
        default: break
        }
        
        MagicalRecord.saveWithBlockAndWait {[weak self] (context: NSManagedObjectContext!) -> Void in
            guard let sself = self else {return}
            guard let contextElement = sself.element?.MR_inContext(context) else {return}
            contextElement.selected = NSNumber(bool: value)
        }
        
        NSManagedObjectContext.MR_defaultContext().MR_saveToPersistentStoreAndWait()
    }
}
