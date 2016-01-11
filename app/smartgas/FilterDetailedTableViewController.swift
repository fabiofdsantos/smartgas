//
//  FilterDetailedTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

protocol FilterDetailedTableViewControllerDelegate
{
    func sendFilter(filter: String)
}

class FilterDetailedTableViewController: UITableViewController {
    
    var filter: [String:Bool]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filter.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if cell!.accessoryType == .Checkmark {
            cell!.accessoryType = .None
        } else {
            cell!.accessoryType = .Checkmark
        }
        /*let section = indexPath.section
        let numberOfRows = tableView.numberOfRowsInSection(section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: row, inSection: section)) {
                cell.accessoryType = row == indexPath.row ? .Checkmark : .None
                /*if cell.accessoryType == .Checkmark {
                    if let fuelText = cell.textLabel?.text {
                        vehicleFuel = fuelText
                        self.delegate?.sendFuel(fuelText)
                    }
                }*/
            }
        }*/
        tableView.reloadData();
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("filterTypeCell", forIndexPath: indexPath) as! FilterTableViewCell
        for (index, entry) in filter.enumerate() {
            if index == indexPath.row {
                cell.setFilter(entry.0)
                if entry.1 {
                    cell.accessoryType = .Checkmark
                }
            }
        }
            
        return cell
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
