//
//  ShowFuelStationTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 04/01/16.
//  Copyright © 2016 Mateus Silva. All rights reserved.
//

import UIKit
import Social

class ShowFuelStationTableViewController: UITableViewController {

    var fuelStation: FuelStation!
    var brand: Brand!
    var district: District!
    var municipality: Municipality!
    var fuelTypes = [FuelType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func shareButton(sender: UIBarButtonItem) {
        let actionSheet = UIAlertController(title: "", message: "Share your location", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let tweetAction = UIAlertAction(title: "Share on Twiter", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                let twitterVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                twitterVC.setInitialText("Preco do combustivel na Reposol")
                self.presentViewController(twitterVC, animated: true, completion: nil)
            } else {
                self.showAlert("You must first log on to your Twitter account.")
            }
            
        }
        
        let facebookAction = UIAlertAction(title: "Share on Facebook", style: UIAlertActionStyle.Default) { (action) -> Void in
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                let facebookVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                facebookVC.setInitialText("Preco do combustivel na Reposol")
                self.presentViewController(facebookVC, animated: true, completion: nil)
                
            }else{
                self.showAlert("You  must first log on to your Facebook account.")
            }
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        actionSheet.addAction(tweetAction)
        actionSheet.addAction(facebookAction)
        actionSheet.addAction(dismissAction)
        
        presentViewController(actionSheet, animated: true, completion: nil)
        
        
    }
    
    
    func showAlert (message:String)->Void{
        let alertController = UIAlertController(title: "Sharing error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    /*override func viewDidAppear(animated: Bool) {
        setMapView()
    }*/

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
                result.setMapView()
            }
        } else if let result = cell as? FuelStationInfoTableViewCell {
            result.nameLabel.text = fuelStation.title
            result.brandLabel.text = brand.name
            result.fuelStationImageView.image = brand.image
            result.addressLabel.text = fuelStation.address
        } else if let result = cell as? FuelStationLocationTableViewCell {
            result.districtLabel.text = "\(municipality.name), \(district.name)"
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
