//
//  Vehicle.swift
//  smartgas
//
//  Created by Mateus Silva on 21/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation
import UIKit


class Vehicle: NSObject, NSCoding {
    var make: String
    var model: String
    var mileageKm: Float?
    var consume: Float?
    var fuel: String?
    var image: UIImage
    

    //Constructors
    init(make: String, model: String, image: UIImage){
        self.make = make
        self.model = model
        self.image = image
    }
    
    override init() {
        make = ""
        model = ""
        image = UIImage()
    }
    
    
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        make = decoder.decodeObjectForKey("make") as! String
        model = decoder.decodeObjectForKey("model") as! String
        mileageKm = decoder.decodeObjectForKey("mileageKm") as? Float ?? 0.0
        consume = decoder.decodeObjectForKey("consume") as? Float ?? 0.0
        fuel = decoder.decodeObjectForKey("fuel") as? String ?? "Diesel"
        image = decoder.decodeObjectForKey("image") as! UIImage
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(make, forKey: "make")
        coder.encodeObject(model, forKey: "model")
        coder.encodeFloat(mileageKm ?? 0.0, forKey: "mileageKm")
        coder.encodeFloat(consume ?? 0.0, forKey: "consume")
        coder.encodeObject(fuel ?? "Diesel", forKey: "fuel")
        coder.encodeObject(image, forKey: "image")
    }

}
