//
//  Achiver.swift
//  smartgas
//
//  Created by Mateus Silva on 26/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation


class Archiver {
    
//    IMPORTANT:
//    Optimize save process because image save is an heavy process
//
    
    func writeVehicle(vehicle: Vehicle) {
        //Need a review
        guard let arrayVehicle = NSUserDefaults().dataForKey("vehiclesArray") else {
            var object:[Vehicle] = []
            object.append(vehicle)
            saveToNSUserDefaults(object, key: "vehiclesArray")
            return
        }
        
        if var vehicleArray = NSKeyedUnarchiver.unarchiveObjectWithData(arrayVehicle) as? [Vehicle] {
            vehicleArray.append(vehicle)
            saveToNSUserDefaults(vehicleArray, key: "vehiclesArray")
        }
    }
    
    
    func updateVehicle(vehicles: [Vehicle]) {
        saveToNSUserDefaults(vehicles, key: "vehiclesArray")
    }
    
    func readVehicle() -> [Vehicle] {
        
        let vehicleArray:[Vehicle] = []
        
        guard let arrayOfObjectsUnarchivedData = NSUserDefaults().dataForKey("vehiclesArray") else {
            return vehicleArray
        }
        
        return NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfObjectsUnarchivedData) as? [Vehicle] ?? vehicleArray
    }
    
    
    //Helper funcs
    private func saveToNSUserDefaults(data: AnyObject, key: String) {
        
        let nsArrayVehicle = NSKeyedArchiver.archivedDataWithRootObject(data)
        NSUserDefaults().setObject(nsArrayVehicle, forKey: key)
    }
}