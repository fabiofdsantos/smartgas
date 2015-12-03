//
//  FuelStation.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation

class FuelStation: NSObject, NSCoding {
    var title: String
    var address: String
    var latitude: Float?
    var longitude: Float?
    var brandId: Int?
    var districtId: Int?
    var municipalityId: Int?
    
    
    //Constructors
    init(title: String, address: String){
        self.title = title
        self.address = address
    }
    
    init(title: String, address: String, latitude: Float, longitude: Float, brandId: Int, districtId: Int, municipalityId: Int){
        self.title = title
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.brandId = brandId
        self.districtId = districtId
        self.municipalityId = municipalityId
    }
    
    override init() {
        title = ""
        address = ""
    }
    
    
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        title = decoder.decodeObjectForKey("title") as! String
        address = decoder.decodeObjectForKey("address") as! String
        latitude = decoder.decodeObjectForKey("latitude") as? Float ?? 0.0
        longitude = decoder.decodeObjectForKey("longitude") as? Float ?? 0.0
        brandId = decoder.decodeObjectForKey("brandId") as? Int ?? 0
        districtId = decoder.decodeObjectForKey("districtId") as? Int ?? 0
        municipalityId = decoder.decodeObjectForKey("municipalityId") as? Int ?? 0
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(title, forKey: "title")
        coder.encodeObject(address, forKey: "address")
        coder.encodeFloat(latitude ?? 0.0, forKey: "latitude")
        coder.encodeFloat(longitude ?? 0.0, forKey: "longitude")
        coder.encodeInteger(brandId ?? 0, forKey: "brandId")
        coder.encodeInteger(districtId ?? 0, forKey: "districtId")
        coder.encodeInteger(municipalityId ?? 0, forKey: "municipalityId")
    }
}