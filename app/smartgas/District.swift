//
//  District.swift
//  smartgas
//
//  Created by Fábio Santos on 07/01/16.
//  Copyright © 2016 Mateus Silva. All rights reserved.
//

import Foundation

class District: NSObject, NSCoding {
    var id: Int!
    var name: String!
    var municipalityId: Int!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    struct Const {
        static let id = "id"
        static let name = "name"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
    }
    
    required init?(coder decoder: NSCoder) {
        id = decoder.decodeIntegerForKey(Const.id)
        name = decoder.decodeObjectForKey(Const.name) as! String
    }
    
    static func saveMany (brands: [District]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let filePath = documentsPath.URLByAppendingPathComponent("Districts.data")
        
        let path = filePath.path!
        
        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }
        
        return false
    }
    
    static func loadAll()  -> [District] {
        var dataToRetrieve = [District]()
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Districts.data", isDirectory: false)
        
        let path = filePath.path!
        
        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [District] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}
