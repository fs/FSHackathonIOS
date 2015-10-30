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
    @IBOutlet weak var titleLabel: UILabel!
    
    func prepareCell(item: Item) {
        self.imageView.image = UIImage(named: item.title!)
        self.titleLabel.text = item.title!
    }
    
}
