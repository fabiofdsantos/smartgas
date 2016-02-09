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

class FilterTableViewController: UITableViewController, FilterDetailedTableViewControllerDelegate {
    var filterFuelType = [String:Bool]()
    var filterBrand = [String:Bool]()
    var filterMain = [String:Bool]()
    var lastType: String!
    let brands = Brand.loadAll()
    let fuelTypes = FuelType.loadAll()
    let filters = FilterTypes.allValues()

    override func viewDidLoad() {
        super.viewDidLoad()

        for brand in brands {
            filterBrand[brand.name] = brand.selected
        }
        for fuelType in fuelTypes {
            filterFuelType[fuelType.name] = fuelType.selected
        }
        for filterItem in filters {
            filterMain[filterItem] = false
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier else {
            return;
        }

        var filter = [String:Bool]()
        if identifier == "brandSegue" {
            filter = filterBrand
        } else if identifier == "fuelSegue" {
            filter = filterFuelType
        } else if identifier == "mainSegue" {
            filter = filterMain
        }

        lastType = identifier

        if let nextView = segue.destinationViewController as? FilterDetailedTableViewController {
            nextView.filter = filter
            nextView.delegate = self
        }

    }


    func sendFilter(filter: [String:Bool]) {
        if lastType == "brandSegue" {
            for (_, content) in filter.enumerate() {
                filterBrand[content.0] = content.1
            }
        } else if lastType == "fuelSegue" {
            for (_, content) in filter.enumerate() {
                filterFuelType[content.0] = content.1
            }
        } else if lastType == "mainSegue" {
            for (_, content) in filter.enumerate() {
                filterMain[content.0] = content.1
            }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)

        if (self.isMovingFromParentViewController()){
            for brand in brands {
                brand.selected = filterBrand[brand.name]
            }
            Brand.saveMany(brands)

            for fuelType in fuelTypes {
                fuelType.selected = filterFuelType[fuelType.name]
            }
            FuelType.saveMany(fuelTypes)
        }
    }


}
