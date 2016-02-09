//
// This file is part of SmartGas, an iOS app to find the best gas station nearby.
//
// (c) Fábio Santos <ffsantos92@gmail.com>
// (c) Mateus Silva <mateusgsilva_@hotmail.com>
// (c) Fábio Marques <fabio1956.epo@gmail.com>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
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
