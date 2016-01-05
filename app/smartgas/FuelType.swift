//
//  FuelTypes.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class FuelType: NSObject, NSCoding {
    var id: Int!
    var type: String!

    //Constructors
    init(id: Int, type: String){
        self.id = id
        self.type = type
    }
    
    override init() {
        id = 0
        type = ""
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        id = decoder.decodeObjectForKey("id") as! Int
        type = decoder.decodeObjectForKey("type") as! String
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(id, forKey: "id")
        coder.encodeObject(type, forKey: "type")
    }
}



/*enum FuelTypes: String {
    case Gasoleo = "Gasóleo"
    case Gasolina95 = "Gasolina 95"
    case Gasolina98 = "Gasolina 98"
    
    static func allValues() -> [String] {
        return [Gasoleo.rawValue, Gasolina95.rawValue, Gasolina98.rawValue]
    }
    
    static func count() -> Int {
        return allValues().count
    }
}*/