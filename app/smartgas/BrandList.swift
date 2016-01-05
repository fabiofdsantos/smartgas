//
//  BrandList.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class BrandList: NSObject, NSCoding {
    
    var brands: [Brand]
    let brandsKey = "brands"
    
    // MARK: - Initializers
    
    override init() {
        brands = [Brand]()
        super.init()
    }
    
    // MARK: - NSCoding
    required init(coder decoder: NSCoder) {
        brands = decoder.decodeObjectForKey(brandsKey) as! [Brand]
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(brands, forKey: brandsKey)
    }
    
}