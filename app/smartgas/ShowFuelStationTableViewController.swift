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

    var fuelStation: FuelStation?
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var fuelStationImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setFuelStationView()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    private func setFuelStationView() {
        guard let fuelStation = self.fuelStation else {
            return
        }
        //brandLabel.text = fuelStation.make
        //nameLabel.text = fuelStation.model
        //fuelStationImageView.image = UIImage(contentsOfFile: fileInDocumentsDirectory(fuelStation.imageName))
        //addressLabel.text = fuelStation.fuel
        //districtLabel = fuelStation.fuel
        //distanceLabel.text = ""
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

    // MARK: - Table view data source

    /*override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    /*override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
