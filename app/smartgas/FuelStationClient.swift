//
//  FuelStationClient.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation

class FuelStationClient {
    
    static func getAllFuelStations(completionHandler: ([FuelStation]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/stations") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url) { (data, response, erro) -> Void in
            if let d = data {
                let fuelStations = FuelStationClient.parseFuelStations(d)
                completionHandler(fuelStations)
            }
        }
        task.resume()
    }
    
    static func parseFuelStations(data:NSData) -> [FuelStation]? {
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                var fuelStations = [FuelStation]()
                
                if let jsonSearch = jsonResponse.objectForKey("stations") as? NSArray {
                    for (var i = 0; i < jsonSearch.count; i++) {
                        if let jsonFuelStation = jsonSearch.objectAtIndex(i) as? NSDictionary {
                            let title = jsonFuelStation.objectForKey("title") as! String
                            let address = jsonFuelStation.objectForKey("address") as! String
                            let latitude = jsonFuelStation.objectForKey("latitude") as! Double
                            let longitude = jsonFuelStation.objectForKey("longitude") as! Double
                            let brandId = jsonFuelStation.objectForKey("brand_id") as! Int
                            let districtId = jsonFuelStation.objectForKey("district_id") as! Int
                            let municipalityId  = jsonFuelStation.objectForKey("municipality_id") as! Int
                            let fuelStation = FuelStation(title: title, address: address, latitude: latitude, longitude: longitude, brandId: brandId, districtId: districtId, municipalityId: municipalityId)
                            fuelStations.append(fuelStation)
                        }
                    }
                }
                return fuelStations
            }
        } catch {
            print (error)
        }
        return nil
    }
}