//
//  FiltersList.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation

enum FilterTypes: String {
    case Distance = "Distance"
    case Price = "Price"
    case Smart = "Smart"
    
    static func allValues() -> [String] {
        return [Distance.rawValue, Price.rawValue, Smart.rawValue]
    }
    
    static func count() -> Int {
        return allValues().count
    }
}