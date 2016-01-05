//
//  Achiver.swift
//  smartgas
//
//  Created by Mateus Silva on 26/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

let vehiclesKey:String = "vehiclesList"


func randomImageName () -> String {
    let charSet: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let size: Int = 10
    let chars = Array(charSet.characters)
    
    var randomString : String = ""
    
    for (var i=0; i < size; i++){
        randomString.append(chars[random() % chars.count])
    }
    
    return randomString
}

func documentsDirectory() -> String {
    let documentsFolderPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
    return documentsFolderPath
}
 
func fileInDocumentsDirectory(filename: String) -> String {
    return (documentsDirectory() as NSString).stringByAppendingPathComponent(filename)
}

func saveVehicles(vehiclesL: VehiclesList, toPath path: String) {
    if NSKeyedArchiver.archiveRootObject(vehiclesL, toFile: path) {
        for item in vehiclesL.vehicles {
            if let image = item.image {
                let imagePath = fileInDocumentsDirectory(item.imageName)
                saveImage(image, toPath: imagePath)
            }
        }
    }
}

func saveImage(image: UIImage, toPath path: String) -> Bool {
    let jpgImageData = UIImageJPEGRepresentation(image, 1.0)
    return jpgImageData!.writeToFile(path, atomically: true)
}

func loadVehiclesFromPath(path: String) -> VehiclesList? {
    return NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? VehiclesList
}

func loadImage(fromPath path: String) -> UIImage? {
    return UIImage(contentsOfFile: path)
}


