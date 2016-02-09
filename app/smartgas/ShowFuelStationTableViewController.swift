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
import Social
import CoreLocation
import MapKit

class ShowFuelStationTableViewController: UITableViewController, CLLocationManagerDelegate {
    var fuelStation: FuelStation!
    var brand: Brand!
    var district: District!
    var municipality: Municipality!
    var fuelTypes = [FuelType]()

    var distance = "..."
    var isMapSet = false

    let locationManager = CLLocationManager()
    var currentLocation = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func shareButton(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "", message: "Share this fuel station", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let tweetAction = UIAlertAction(title: "Share on Twiter", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterVC.setInitialText("I went to \(self.brand.name) called \(self.fuelStation.title) at \(self.municipality.name), \(self.district.name).")
                self.presentViewController(twitterVC, animated: true, completion: nil)
            } else {
                self.showAlert("You must first login to your Twitter account.")
            }

        }

        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookVC.setInitialText("I went to \(self.brand.name) called \(self.fuelStation.title) at \(self.municipality.name), \(self.district.name).")
                self.presentViewController(facebookVC, animated: true, completion: nil)

            }else{
                self.showAlert("You must first login to your Facebook account.")
            }
        }

        let navigationAlert = UIAlertAction(title: "Bring me to this station", style: UIAlertActionStyle.Default) { (action) -> Void in

            let lat1 : NSString = String(self.fuelStation.latitude)
            let lng1 : NSString = String(self.fuelStation.longitude)

            let latitute:CLLocationDegrees =  lat1.doubleValue
            let longitute:CLLocationDegrees =  lng1.doubleValue

            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitute, longitute)

            let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(MKCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = self.brand.name
            mapItem.openInMapsWithLaunchOptions(options)

        }

        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) { (action) -> Void in

        }

        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(navigationAlert)
        actionSheet.addAction(dismissAction)

        presentViewController(actionSheet, animated: true, completion: nil)
    }


    func showAlert (message:String)->Void{
        let alertController = UIAlertController(title: "Sharing error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return fuelStation.prices.count
        } else if section == 2 {
            return 2
        } else {
            return 1
        }
    }

    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section) {
        case 0:
            return "Main Information"
        case 1:
            return "Prices"
        default: //case 2:
            return "Location"
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationInfo") as! FuelStationInfoTableViewCell
            return cell.frame.height
        case (1, _):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationPrice") as! FuelStationPriceTableViewCell
            return cell.frame.height
        case (2, 0):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationLocation") as! FuelStationLocationTableViewCell
            return cell.frame.height
        default: //= case (2, 1):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationMap") as! FuelStationMapTableViewCell
            return cell.frame.height
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationInfo", forIndexPath: indexPath) as! FuelStationInfoTableViewCell
            return cell
        case (1, _):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationPrice", forIndexPath: indexPath) as! FuelStationPriceTableViewCell
            return cell
        case (2, 0):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationLocation", forIndexPath: indexPath) as! FuelStationLocationTableViewCell
            return cell
        default: //= case (2, 1):
            let cell = tableView.dequeueReusableCellWithIdentifier("fuelStationMap", forIndexPath: indexPath) as! FuelStationMapTableViewCell
            return cell
        }
    }

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let result = cell as? FuelStationMapTableViewCell {
            if result.latitude == nil && result.longitude == nil {
                result.latitude = fuelStation.latitude
                result.longitude = fuelStation.longitude
                result.stationName = fuelStation.title
                result.brandName = brand.name
                result.setMapView()
            }
        } else if let result = cell as? FuelStationInfoTableViewCell {
            result.nameLabel.text = fuelStation.title
            result.brandLabel.text = brand.name
            result.fuelStationImageView.image = brand.image
            result.addressLabel.text = fuelStation.address
        } else if let result = cell as? FuelStationLocationTableViewCell {
            result.districtLabel.text = "\(municipality.name), \(district.name)"
            result.distanceLabel.text = "\(distance)km"
        } else if let result = cell as? FuelStationPriceTableViewCell {
            var index = 0
            for (key, value) in fuelStation.prices {
                if index == indexPath.row {
                    result.priceLabel.text = "\(value)€"
                    for fuelType in fuelTypes {
                        if fuelType.id == key {
                            result.typeLabel.text = fuelType.name
                        }
                    }
                }
                index++
            }
        }
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

            let stationLocation = CLLocation(latitude: fuelStation.latitude!, longitude: fuelStation.longitude!)
            let distance = String(format:"%.1f", locations.last!.distanceFromLocation(stationLocation)/1000)
            self.distance = distance
            var paths = [NSIndexPath]()
            paths.append(NSIndexPath(forRow: 0, inSection: 2))
            tableView.reloadRowsAtIndexPaths(paths, withRowAnimation: UITableViewRowAnimation.None)
        }
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        locationManager.startUpdatingLocation()
    }
}
