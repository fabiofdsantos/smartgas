//
//  FuelTypeList.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class FuelTypeList: NSObject, NSCoding {
    
    var fuelTypes: [FuelType]
    let fuelTypesKey = "fuelTypes"
    
    // MARK: - Initializers
    
    override init() {
        fuelTypes = [FuelType]()
        super.init()
    }
    
    // MARK: - NSCoding
    required init(coder decoder: NSCoder) {
        fuelTypes = decoder.decodeObjectForKey(fuelTypesKey) as! [FuelType]
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(fuelTypes, forKey: fuelTypesKey)
    }
}