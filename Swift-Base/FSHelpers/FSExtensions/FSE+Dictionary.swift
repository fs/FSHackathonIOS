//
//  FSExtensions+Dictionary.swift
//  SwiftHelpers
//
//  Created by Kruperfone on 31.07.15.
//  Copyright (c) 2015 FlatStack. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func objectForKey(key:Key, orDefault def:Value) -> Value {
        guard let value = self[key] else {return def}
        return value
    }
}
