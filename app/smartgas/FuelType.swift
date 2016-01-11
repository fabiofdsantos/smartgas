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
    var name: String!
    var selected: Bool!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.selected = false
    }
    
    struct Const {
        static let id = "id"
        static let name = "name"
        static let selected = "selected"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
        coder.encodeBool(selected, forKey: Const.selected)
    }
    
    required init?(coder decoder: NSCoder) {
        id = decoder.decodeIntegerForKey(Const.id)
        name = decoder.decodeObjectForKey(Const.name) as! String
        selected = decoder.decodeBoolForKey(Const.selected)
    }
    
    static func saveMany (brands: [FuelType]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let filePath = documentsPath.URLByAppendingPathComponent("FuelTypes.data")
        
        let path = filePath.path!
        
        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }
        
        return false
    }
    
    static func loadAll() -> [FuelType] {
        var dataToRetrieve = [FuelType]()
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("FuelTypes.data", isDirectory: false)
        
        let path = filePath.path!
        
        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [FuelType] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}