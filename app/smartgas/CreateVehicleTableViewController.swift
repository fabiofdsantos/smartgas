//
//  CreateVehicleTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 21/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class CreateVehicleTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    
    var vehicle: Vehicle = Vehicle()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setKeyboardHelper()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func setKeyboardHelper() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboard = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(keyboard.CGRectValue().height, duration: animationDuration.doubleValue)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: animationDuration.doubleValue)
    }
    
    func animateToKeyboardHeight(kbHeight: CGFloat, duration: Double) {
        //print("HEIGHT: \(kbHeight)\nDURANTION: \(duration)")
        //print("TOP: \(self.tableView.contentInset.top)\nBOTTOM: \(self.tableView.contentInset.bottom)\nLEFT: \(self.tableView.contentInset.left)\nRIGHT: \(self.tableView.contentInset.left)\n")
        UIView.animateWithDuration(duration, animations: {
            self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, kbHeight, self.tableView.contentInset.left)
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, kbHeight, self.tableView.contentInset.left)
        })
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    // Methods removed so static table could work
    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */

    @IBAction func cancelBarButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBarButton(sender: UIBarButtonItem) {
        if let makeTF = makeTextField.text {
            vehicle.make = makeTF
        }
        
        if let modelTF = modelTextField.text {
            vehicle.model = modelTF
        }
        
        if let imageIV = carImageView.image {
            vehicle.image = imageIV
        }
        
        Archiver().writeVehicle(vehicle)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func addCarImage(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }

    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        carImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableCell = tableView.cellForRowAtIndexPath(indexPath)
            
        for view in tableCell!.contentView.subviews {
            if let textField = view as? UITextField {
                textField.select(textField)
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextView:FuelTypeTableViewController = segue.destinationViewController as! FuelTypeTableViewController {
            nextView.vehicle = vehicle
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if let fuelTL = vehicle.fuel {
            fuelTypeLabel.text = fuelTL
        }
    }

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
