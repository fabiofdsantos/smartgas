//
//  VehiclesList.swift
//  smartgas
//
//  Created by Mateus Silva on 11/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class VehiclesList: NSObject, NSCoding {
    
    var vehicles: [Vehicle]
    let vehiclesKey = "vehicles"
    
    // MARK: - Initializers
    
    override init() {
        vehicles = [Vehicle]()
        super.init()
    }
    
    // MARK: - NSCoding
    required init(coder decoder: NSCoder) {
        vehicles = decoder.decodeObjectForKey(vehiclesKey) as! [Vehicle]
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(vehicles, forKey: vehiclesKey)
    }
    
}