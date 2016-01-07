//
//  FuelStationClient.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import Foundation
import UIKit

class WebServiceClient {
    
    static func getAllFuelStations(completionHandler: ([FuelStation]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/stations") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let d = data {
                completionHandler(self.parseFuelStations(d))
            } else {
                print("Can't connect to webservice.")
            }
        }
        
        task.resume()
    }
    
    static func parseFuelStations(data:NSData) -> [FuelStation]! {
        var fuelStations = [FuelStation]()
        
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                
                for station in (jsonResponse.objectForKey("stations") as! NSArray) {
                    
                    fuelStations.append(
                        FuelStation(
                            title: station.objectForKey("title") as! String,
                            address: station.objectForKey("address") as! String,
                            latitude: station.objectForKey("latitude") as! Double,
                            longitude: station.objectForKey("longitude") as! Double,
                            brandId: station.objectForKey("brand_id") as! Int,
                            districtId: station.objectForKey("district_id") as! Int,
                            municipalityId: station.objectForKey("municipality_id") as! Int
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        return fuelStations
    }
    
    
    static func getAllBrands(completionHandler: ([Brand]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/brands") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let d = data {
                completionHandler(self.parseBrands(d))
            } else {
                print("Can't connect to webservice.")
            }
        }
        
        task.resume()
    }
    
    static func parseBrands(data:NSData) -> [Brand]! {
        var brands = [Brand]()
        
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                
                for brand in (jsonResponse.objectForKey("brands") as! NSArray) {
                    let base64Image = brand.objectForKey("image") as! String
                    let decodedData = NSData(base64EncodedString: base64Image, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters)
                    
                    brands.append(
                        Brand(
                            id: brand.objectForKey("id") as! Int,
                            name: brand.objectForKey("value") as! String,
                            image: UIImage(data: decodedData!)!
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        if (Brand.saveMany(brands)) {
            return brands
        }
        
        return [Brand]()
    }
    
    static func getAllFuelTypes(completionHandler: ([FuelType]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/types") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let d = data {
                completionHandler(self.parseFuelTypes(d))
            } else {
                print("Can't connect to webservice.")
            }
        }
        
        task.resume()
    }
    
    static func parseFuelTypes(data:NSData) -> [FuelType]! {
        var fuelTypes = [FuelType]()
        
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                
                for brand in (jsonResponse.objectForKey("types") as! NSArray) {
                    fuelTypes.append(
                        FuelType(
                            id: brand.objectForKey("id") as! Int,
                            name: brand.objectForKey("value") as! String
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        return fuelTypes
    }


}
