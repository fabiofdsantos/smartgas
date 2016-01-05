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

    //Constructors
    /*init(make: String, model: String, image: UIImage){
        self.make = make
        self.model = model
        self.image = image
        
        super.init()
    }*/
    
    init(make: String, model: String, imageName: String){
        self.make = make
        self.model = model
        self.imageName = imageName
        
        super.init()
    }
    
    
    // MARK: NSCoding
    required init(coder decoder: NSCoder) {
        self.make = decoder.decodeObjectForKey("make") as! String
        self.model = decoder.decodeObjectForKey("model") as! String
        self.mileageKm = decoder.decodeObjectForKey("mileageKm") as? Float ?? 0.0
        self.consume = decoder.decodeObjectForKey("consume") as? Float ?? 0.0
        self.fuel = decoder.decodeObjectForKey("fuel") as? String ?? "Diesel"
        self.imageName = decoder.decodeObjectForKey("imageName") as! String
        //self.image = UIImage(contentsOfFile: loadImageFileName(imageName!))!
        //print(loadImageFileName(imageName!))
        
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(make, forKey: "make")
        coder.encodeObject(model, forKey: "model")
        coder.encodeFloat(mileageKm ?? 0.0, forKey: "mileageKm")
        coder.encodeFloat(consume ?? 0.0, forKey: "consume")
        coder.encodeObject(fuel ?? "Diesel", forKey: "fuel")
        coder.encodeObject(imageName, forKey: "imageName")
    }
    
}
