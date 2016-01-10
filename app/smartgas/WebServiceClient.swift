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
                    let prices = getPrices(station.objectForKey("prices") as! NSArray) as [Int:Double]
                    
                    fuelStations.append(
                        FuelStation(
                            title: station.objectForKey("title") as! String,
                            address: station.objectForKey("address") as! String,
                            latitude: station.objectForKey("latitude") as! Double,
                            longitude: station.objectForKey("longitude") as! Double,
                            brandId: station.objectForKey("brand_id") as! Int,
                            districtId: station.objectForKey("district_id") as! Int,
                            municipalityId: station.objectForKey("municipality_id") as! Int,
                            prices: prices
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        return fuelStations
    }
    
    static func getPrices(stationPrices: NSArray) -> [Int:Double]! {
        var prices = [Int:Double]()
        for price in stationPrices {
            prices[price.objectForKey("type_id") as! Int] = price.objectForKey("value") as? Double
        }
        return prices
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
    
    static func getAllDistricts(completionHandler: ([District]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/districts") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let d = data {
                completionHandler(self.parseDistricts(d))
            } else {
                print("Can't connect to webservice.")
            }
        }
        
        task.resume()
    }
    
    static func parseDistricts(data:NSData) -> [District]! {
        var districts = [District]()
        
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                
                for district in (jsonResponse.objectForKey("districts") as! NSArray) {
                    districts.append(
                        District(
                            id: district.objectForKey("id") as! Int,
                            name: district.objectForKey("value") as! String
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        return districts
    }

    
    static func getAllMunicipalities(completionHandler: ([Municipality]?) -> Void) {
        guard let url = NSURL(string: "http://46.101.79.241/municipalities") else {
            return
        }
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            if let d = data {
                completionHandler(self.parseMunicipalities(d))
            } else {
                print("Can't connect to webservice.")
            }
        }
        
        task.resume()
    }
    
    static func parseMunicipalities(data:NSData) -> [Municipality]! {
        var municipalities = [Municipality]()
        
        do {
            if let jsonResponse = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary {
                
                for municipality in (jsonResponse.objectForKey("municipalities") as! NSArray) {
                    municipalities.append(
                        Municipality(
                            id: municipality.objectForKey("id") as! Int,
                            name: municipality.objectForKey("value") as! String,
                            districtId: municipality.objectForKey("district_id") as! Int
                        )
                    )
                }
            }
        } catch {
            print (error)
        }
        
        return municipalities
    }
}
