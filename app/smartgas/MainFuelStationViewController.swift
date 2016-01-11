//
//  MainFuelStationViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 22/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit
import CoreLocation

class MainFuelStationViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    var brands:[Brand]!
    var fuelStations:[FuelStation]!
    var districts:[District]!
    var municipalities:[Municipality]!
    var fuelTypes:[FuelType]!
    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()
    
    var tableRows = 0
    
    let showFuelStationSegueIdentifier = "showFuelStation"
    
    @IBOutlet weak var fuelStationTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {						
        super.viewDidLoad()
        
        fuelStationTableView.delegate = self
        fuelStationTableView.dataSource = self
        
        searchBar.delegate = self

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fuelStationLoad:", name:"fuelStationsReady", object: nil)
        
        locationInit()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func fuelStationLoad(notification: NSNotification){
        self.fuelStations = FuelStation.loadAll()
        self.brands = Brand.loadAll()
        self.districts = District.loadAll()
        self.municipalities = Municipality.loadAll()
        self.fuelTypes = FuelType.loadAll()
        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
            self.fuelStationTableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableRows = 0
        if let stations = fuelStations {
            for station in stations {
                if station.active == true {
                    tableRows++
                }
            }
        }
        return tableRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationCell", forIndexPath: indexPath) as! FuelStationTableViewCell
        
        var cellIndex = 0
        if let stations = fuelStations {
            for station in stations {
                if cellIndex == indexPath.row {
                    cell.setFuelStation(station, brands: brands)
                }
                if station.active == true {
                    cellIndex++
                }
            }
        }
        
        return cell
    }
    
    func locationInit() {
        locationManager.delegate = self
        UIDevice.currentDevice().batteryMonitoringEnabled = true
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "batteryStateDidChange:", name: UIDeviceBatteryStateDidChangeNotification, object: nil)
        if UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Charging || UIDevice.currentDevice().batteryState == UIDeviceBatteryState.Full {
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        } else {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
        locationManager.distanceFilter = kCLDistanceFilterNone
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func batteryStateDidChange(notification: NSNotification) {
        print("BATTERY STATE CHANGE")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinates = locations.last?.coordinate {
            currentLocation = coordinates
            
            for var index = 0; index < tableRows; index++ {
                let stationLocation = CLLocation(latitude: fuelStations[index].latitude!, longitude: fuelStations[index].longitude!)
                let distance = String(format:"%.1f", locations.last!.distanceFromLocation(stationLocation)/1000)
                let cell = fuelStationTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
                if let cellResult = cell as? FuelStationTableViewCell {
                    cellResult.setDistance(distance)
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fuelStation = fuelStations![indexPath.row]
        print(fuelStation.title)
        performSegueWithIdentifier(showFuelStationSegueIdentifier, sender: fuelStation)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        guard let identifier = segue.identifier else {
            return;
        }
        
        if identifier == showFuelStationSegueIdentifier {
            if let nextController = segue.destinationViewController.childViewControllers[0] as? ShowFuelStationTableViewController {
                if let fuelStation = sender as? FuelStation {
                    nextController.fuelStation = fuelStation
                    for brand in brands {
                        if brand.id == fuelStation.brandId {
                            nextController.brand = brand
                        }
                    }
                    
                    for district in districts {
                        if district.id == fuelStation.districtId {
                            nextController.district = district
                        }
                    }
                    
                    for municipality in municipalities {
                        if municipality.id == fuelStation.municipalityId {
                            nextController.municipality = municipality
                        }
                    }
                    
                    for fuelType in fuelTypes {
                        if fuelStation.prices[fuelType.id] != nil {
                            nextController.fuelTypes.append(fuelType)
                        }
                    }
                }
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if let stations = fuelStations {
            for station in stations {
                let text = station.title
                if text.lowercaseString.rangeOfString(searchText.lowercaseString) != nil || searchText == "" {
                    station.active = true
                }else{
                    station.active = false
                }
            }
            self.fuelStationTableView.reloadData()
        }
    }
    

}
