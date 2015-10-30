//
//  ListTableViewCell.swift
//  Swift-Base
//
//  Created by Vladimir Goncharov on 30.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    //MARK: - UI
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - cell
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = nil
    }
    
//    func prepareCell(list: List) {
//        self.nameLabel.text = list.title
//    }
}
