//
//  FuelTypes.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

enum FuelTypes: String {
    case Gasoleo = "Gasóleo"
    case Gasolina95 = "Gasolina 95"
    case Gasolina98 = "Gasolina 98"
    
    static func allValues() -> [String] {
        return [Gasoleo.rawValue, Gasolina95.rawValue, Gasolina98.rawValue]
    }
    
    static func count() -> Int {
        return allValues().count
    }
}