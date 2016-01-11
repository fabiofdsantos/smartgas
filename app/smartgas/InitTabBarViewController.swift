//
//  InitTabBarViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 09/01/16.
//  Copyright © 2016 Mateus Silva. All rights reserved.
//

import UIKit

class InitTabBarViewController: UITabBarController {
    var brands:[Brand]!
    var fuelStations:[FuelStation]!
    var districts:[District]!
    var municipalities:[Municipality]!
    var fuelTypes:[FuelType]!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWSData()
    }
    
    private func getWSData() {
        if District.loadAll().count == 0 {
            WebServiceClient.getAllDistricts({ (districts) -> Void in
                self.districts = districts
                District.saveMany(self.districts)
            })
        }
        
        if Brand.loadAll().count == 0 {
            WebServiceClient.getAllBrands({ (brands) -> Void in
                self.brands = brands
                Brand.saveMany(self.brands)
            })
        }
        
        if FuelType.loadAll().count == 0 {
            WebServiceClient.getAllFuelTypes({ (fuelTypes) -> Void in
                self.fuelTypes = fuelTypes
                FuelType.saveMany(self.fuelTypes)
            })
        }
        
        if Municipality.loadAll().count == 0 {
            WebServiceClient.getAllMunicipalities({ (municipalities) -> Void in
                self.municipalities = municipalities
                Municipality.saveMany(self.municipalities)
            })
        }
        
        //if FuelStation.loadAll().count == 0 {
            WebServiceClient.getAllFuelStations({ (fuelStations) -> Void in
                self.fuelStations = fuelStations
                FuelStation.saveMany(self.fuelStations)
                NSNotificationCenter.defaultCenter().postNotificationName("fuelStationsReady", object: nil)
            })
        /*} else {
            NSNotificationCenter.defaultCenter().postNotificationName("fuelStationsReady", object: nil)
        }*/
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
