//
//  VehicleTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 26/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    
    var vehiclesList: [Vehicle]!
    
    let addVehicleSegueIdentifier = "addVehicle"
    let editVehicleSegueIdentifier = "editVehicle"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.vehiclesList = Vehicle.loadAll()
        
        navigationItem.leftBarButtonItem = editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.vehiclesList = Vehicle.loadAll()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vehiclesList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("vehicleCell", forIndexPath: indexPath) as! VehicleTableViewCell

        let vehicle = vehiclesList[indexPath.row]
        cell.setVehicle(vehicle)

        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // remove the deleted item from the model
            self.vehiclesList.removeAtIndex(indexPath.row)
            
            // remove the deleted item from the `UITableView`
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            Vehicle.saveMany(vehiclesList)
        }
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // remove the dragged row's model
        let moved = self.vehiclesList.removeAtIndex(sourceIndexPath.row)
        
        // insert it into the new position
        self.vehiclesList.insert(moved, atIndex: destinationIndexPath.row)
        
        Vehicle.saveMany(vehiclesList)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let identifier = segue.identifier!
        
        if identifier == addVehicleSegueIdentifier {
            if let nextController = segue.destinationViewController.childViewControllers[0] as? CreateVehicleTableViewController {
                nextController.vehiclesList = self.vehiclesList
            }
        } else if identifier == editVehicleSegueIdentifier {
            if let vehicle = sender as? Vehicle {
                if let nextController = segue.destinationViewController.childViewControllers[0] as? CreateVehicleTableViewController {
                    nextController.vehiclesList = self.vehiclesList
                    nextController.vehicle = vehicle
                }
            }
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vehicle = vehiclesList[indexPath.row]
        
        performSegueWithIdentifier(editVehicleSegueIdentifier, sender: vehicle)
    }

}
