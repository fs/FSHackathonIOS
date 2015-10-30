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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.layer.cornerRadius = self.imageView.bounds.width * 0.5
    }
    
    func prepareCell(item: Item) {
        self.imageView.image = UIImage(named: "\(item.title!).jpg")
        self.titleLabel.text = item.title!
    }
    
}
