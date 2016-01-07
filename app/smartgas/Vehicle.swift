//
//  Vehicle.swift
//  smartgas
//
//  Created by Mateus Silva on 21/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class Vehicle: NSObject, NSCoding {
    var make: String
    var model: String
    var mileageKm: Float?
    var consume: Float?
    var fuel: String?
    
    var image: UIImage?
    
    var imageName: String
    
    init(make: String, model: String, imageName: String){
        self.make = make
        self.model = model
        self.imageName = imageName
    }
    
    struct Const {
        static let make = "make"
        static let model = "model"
        static let mileageKm = "mileageKm"
        static let consume = "consume"
        static let fuel = "fuel"
        static let image = "image"
        static let imageName = "imageName"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(make, forKey: Const.make)
        coder.encodeObject(model, forKey: Const.model)
        coder.encodeFloat(mileageKm ?? 0.0, forKey: Const.mileageKm)
        coder.encodeFloat(consume ?? 0.0, forKey: Const.consume)
        coder.encodeObject(fuel ?? "Diesel", forKey: Const.fuel)
        coder.encodeObject(imageName, forKey: Const.imageName)
    }
    
    required init?(coder decoder: NSCoder) {
        self.make = decoder.decodeObjectForKey(Const.make) as! String
        self.model = decoder.decodeObjectForKey(Const.model) as! String
        self.mileageKm = decoder.decodeObjectForKey(Const.mileageKm) as? Float ?? 0.0
        self.consume = decoder.decodeObjectForKey(Const.consume) as? Float ?? 0.0
        self.fuel = decoder.decodeObjectForKey(Const.fuel) as? String ?? "Diesel"
        self.imageName = decoder.decodeObjectForKey(Const.imageName) as! String
        //self.image = UIImage(contentsOfFile: loadImageFileName(imageName!))!
        //print(loadImageFileName(imageName!))
    }
    
    static func saveMany (brands: [Vehicle]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let filePath = documentsPath.URLByAppendingPathComponent("Vehicles.data")
        
        let path = filePath.path!
        
        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }
        
        return false
    }
    
    static func loadAll() -> [Vehicle] {
        var dataToRetrieve = [Vehicle]()
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Vehicles.data", isDirectory: false)
        
        let path = filePath.path!
        
        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Vehicle] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }

    
}
