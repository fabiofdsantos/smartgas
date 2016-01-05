//
//  VehicleTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 26/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    
    var vehiclesList: VehiclesList!
    var vehiclesPath: String!
    
    let addVehicleSegueIdentifier = "addVehicle"
    let editVehicleSegueIdentifier = "editVehicle"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        vehiclesPath = fileInDocumentsDirectory("vehicles.list")
        loadVehicles()
        
        //Add working edit button to the left of the navigation bar
        navigationItem.leftBarButtonItem = editButtonItem()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return vehiclesList.vehicles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vehicleCell", forIndexPath: indexPath) as! VehicleTableViewCell

        let vehicle = vehiclesList.vehicles[indexPath.row]
        cell.setVehicle(vehicle)

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // remove the deleted item from the model
            self.vehiclesList.vehicles.removeAtIndex(indexPath.row)
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            saveVehicles(vehiclesList, toPath: vehiclesPath)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // remove the dragged row's model
        let moved = self.vehiclesList.vehicles.removeAtIndex(sourceIndexPath.row)
        
        // insert it into the new position
        self.vehiclesList.vehicles.insert(moved, atIndex: destinationIndexPath.row)
        
        saveVehicles(vehiclesList, toPath: vehiclesPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let identifier = segue.identifier!
        
        if identifier == addVehicleSegueIdentifier {
            if let nextController = segue.destinationViewController.childViewControllers[0] as? CreateVehicleTableViewController {
                nextController.vehiclesPath = self.vehiclesPath
                nextController.vehiclesList = self.vehiclesList
            }
        } else if identifier == editVehicleSegueIdentifier {
            if let vehicle = sender as? Vehicle {
                if let nextController = segue.destinationViewController.childViewControllers[0] as? CreateVehicleTableViewController {
                    nextController.vehiclesPath = self.vehiclesPath
                    nextController.vehiclesList = self.vehiclesList
                    nextController.vehicle = vehicle
                }
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vehicle = vehiclesList.vehicles[indexPath.row]
        
        performSegueWithIdentifier(editVehicleSegueIdentifier, sender: vehicle)
    }
    
    func loadVehicles() {
        if let vehicles = loadVehiclesFromPath(vehiclesPath) {
            self.vehiclesList = vehicles
        } else {
            self.vehiclesList = VehiclesList()
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
