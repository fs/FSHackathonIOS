//
//  Constants.swift
//  Swift-Base
//
//  Created by Kruperfone on 02.10.14.
//  Copyright (c) 2014 Flatstack. All rights reserved.
//

import UIKit

/*----------API keys---------*/
let SBKeyAPIKeyCrashlitycs  = ""
let SBKeyAPIKeyGoogle       = ""

/*--------------User Defaults keys-------------*/
let SBKeyUserDefaultsDeviceTokenData = "kUserDefaultsDeviceTokenData"
let SBKeyUserDefaultsDeviceTokenString = "kUserDefaultsDeviceTokenString"

/*----------Notifications---------*/
let SBNotificationMock:String = "mock_notification";

/*--------------Fonts-------------*/

//Example of custom font family name
enum FontFamilyName {
    case Regular
    case Bold
    case Italic
    
    static let fontFamilyName = "FontFamilyName"
    static let allValues = [FontFamilyName.Regular, FontFamilyName.Bold, FontFamilyName.Italic]
    
    var description : String {
        switch self {
        case .Regular:  return "FontFamilyName-Regular";
        case .Bold:     return "FontFamilyName-Bold";
        case .Italic:   return "FontFamilyName-Italic";
        }
    }
    
    func font (size:CGFloat) -> UIFont? {
        switch self {
        case .Regular:  return UIFont(name: self.description, size: size)
        case .Bold:     return UIFont(name: self.description, size: size)
        case .Italic:   return UIFont(name: self.description, size: size)
        }
    }
}

/*----------Colors----------*/

//Example of custom color schemes in application
let MyRedApplicationColor = UIColor.redColor()
let MyGreenApplicationColor = UIColor.greenColor()

enum Unit: String {
    
    case Kilogramm = "Масса"
    case Volume = "Объем"
    case Count = "Штука"
    case Gramm = "Грамм"
    case Undefined = ""
    
    var short: String {
        
        switch self {
        case .Kilogramm   : return "кг"
        case .Volume      : return "л"
        case .Count       : return "шт"
        case .Gramm       : return "гр"
        case .Undefined   : return ""
        }
    }
    
    init?(intValue: Int16) {
        
        switch intValue {
        case 0: self = .Kilogramm
        case 1: self = .Volume
        case 2: self = .Count
        case 3: self = .Gramm
        default: self = .Undefined
        }
    }
    
    var numberValue: NSNumber {
        
        switch self {
        case .Kilogramm   : return NSNumber(float: 0.0)
        case .Volume      : return NSNumber(float: 1.0)
        case .Count       : return NSNumber(float: 2.0)
        case .Gramm       : return NSNumber(float: 3.0)
        case .Undefined   : return NSNumber(float: -1.0)
        }
    }
}
