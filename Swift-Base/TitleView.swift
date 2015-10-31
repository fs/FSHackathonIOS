//
//  TitleView.swift
//  Swift-Base
//
//  Created by Galiev Aynur on 31.10.15.
//  Copyright © 2015 Flatstack. All rights reserved.
//

import UIKit

class TitleView: UIView {

    @IBOutlet weak var title: UILabel!
    
    class func createView() -> TitleView {
        return NSBundle.mainBundle().loadNibNamed("TitleView", owner: nil, options: nil).first as! TitleView
    }

}
