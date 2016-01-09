//
//  FuelStation.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation

class FuelStation: NSObject, NSCoding {
    var title: String!
    var address: String!
    var latitude: Double!
    var longitude: Double!
    var brandId: Int!
    var districtId: Int!
    var municipalityId: Int!
    
    init(title: String, address: String, latitude: Double, longitude: Double, brandId: Int, districtId: Int, municipalityId: Int){
        self.title = title
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.brandId = brandId
        self.districtId = districtId
        self.municipalityId = municipalityId
    }
    
    struct Const {
        static let title = "title"
        static let address = "address"
        static let latitude = "latitude"
        static let longitude = "longitude"
        static let brandId = "brandId"
        static let districtId = "districtId"
        static let municipalityId = "municipalityId"
    }
    
    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(title, forKey: Const.title)
        coder.encodeObject(address, forKey: Const.address)
        coder.encodeDouble(latitude, forKey: Const.latitude)
        coder.encodeDouble(longitude, forKey: Const.longitude)
        coder.encodeInteger(brandId, forKey: Const.brandId)
        coder.encodeInteger(districtId, forKey: Const.districtId)
        coder.encodeInteger(municipalityId, forKey: Const.municipalityId)
    }
    
    required init?(coder decoder: NSCoder) {
        title = decoder.decodeObjectForKey(Const.title) as! String
        address = decoder.decodeObjectForKey(Const.address) as! String
        latitude = decoder.decodeDoubleForKey(Const.latitude) 
        longitude = decoder.decodeDoubleForKey(Const.longitude) 
        brandId = decoder.decodeIntegerForKey(Const.brandId) 
        districtId = decoder.decodeIntegerForKey(Const.districtId)
        municipalityId = decoder.decodeIntegerForKey(Const.municipalityId)
    }
    
    static func saveMany (brands: [FuelStation]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        
        let filePath = documentsPath.URLByAppendingPathComponent("FuelStations.data")
        
        let path = filePath.path!
        
        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }
        
        return false
    }
    
    static func loadAll()  -> [FuelStation] {
        var dataToRetrieve = [FuelStation]()
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("FuelStations.data", isDirectory: false)
        
        let path = filePath.path!
        
        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [FuelStation] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}