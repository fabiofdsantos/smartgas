//
//  Brand.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class Brand: NSObject, NSCoding {
    var id: Int!
    var name: String!
    var image: UIImage!
    var selected: Bool!
    
    init(id: Int, name: String, image: UIImage){
        self.id = id
        self.name = name
        self.image = image
        self.selected = true
    }
    
    struct Const {
        static let id = "id"
        static let name = "name"
        static let image = "image"
        static let selected = "selected"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
        coder.encodeObject(image, forKey: Const.image)
        coder.encodeBool(selected, forKey: Const.selected)
    }
    
    required init?(coder decoder: NSCoder) {
        id = decoder.decodeObjectForKey(Const.id) as! Int
        name = decoder.decodeObjectForKey(Const.name) as! String
        image = decoder.decodeObjectForKey(Const.image) as! UIImage
        selected = decoder.decodeBoolForKey(Const.selected)
    }
    
    static func saveMany (brands: [Brand]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let filePath = documentsPath.URLByAppendingPathComponent("Brands.data")
        
        let path = filePath.path!
        
        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }
        
        return false
    }
    
    static func loadAll()  -> [Brand] {
        var dataToRetrieve = [Brand]()
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Brands.data", isDirectory: false)
        
        let path = filePath.path!
        
        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Brand] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}