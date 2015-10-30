//
//  ItemListCollectionViewCell.swift
//  Swift-Base
//
//  Created by Nikita Fomin on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ItemListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    var titleLabel: UILabel!
    
    var tappedBlock     : ((cell: ItemListCollectionViewCell)->(Void))?
    var longPressedBlock: ((cell: ItemListCollectionViewCell)->(Void))?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.addSubview(visualEffect)
        let leadingConstraint = NSLayoutConstraint(item: visualEffect, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.imageView, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: visualEffect, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.imageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: visualEffect, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self.imageView, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: visualEffect, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 40.0)
        
        visualEffect.addConstraint(heightConstraint)
        self.imageView.addConstraints([leadingConstraint, trailingConstraint, bottomConstraint])
        self.imageView.layoutIfNeeded()
        
        self.titleLabel = UILabel()
        self.titleLabel.text = " "
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 20.0)
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.numberOfLines = 1
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.minimumScaleFactor = 0.6
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.shadowOffset = CGSizeMake(1, 0)
        self.titleLabel.shadowColor = UIColor.darkGrayColor()
        
        visualEffect.addSubview(self.titleLabel)
        
        let lConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: visualEffect, attribute: NSLayoutAttribute.Leading, multiplier: 1.0, constant: 0.0)
        let tConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: visualEffect, attribute: NSLayoutAttribute.Trailing, multiplier: 1.0, constant: 0.0)
        let centerYConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: visualEffect, attribute: NSLayoutAttribute.CenterY, multiplier: 1.0, constant: 0.0)
        visualEffect.addConstraints([lConstraint, tConstraint, centerYConstraint])
        
        self.imageView.layer.cornerRadius = 10
    }
    
    func prepareCell(item: Item) {
        self.imageView.image = UIImage(named: "\(item.title!).jpg")
        self.titleLabel.text = item.title!
    }
    
}
