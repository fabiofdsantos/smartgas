//
//  CreateVehicleTableViewController.swift
//  smartgas
//
//  Created by Mateus Silva on 21/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class CreateVehicleTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, FuelTypeTableViewControllerDelegate {
    
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var fuelTypeLabel: UILabel!
    @IBOutlet weak var imageLabel: UILabel!
    
    var tapGesture: UITapGestureRecognizer?
    var textFieldHelper: UITextField?
    var imagePickerController: UIImagePickerController!
    
    var vehicle: Vehicle?
    var vehiclesList: VehiclesList!
    var vehiclesPath: String?
    var vehicleFuel: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setKeyboardHelper()
        self.createInputsFromVehicle()
        
        makeTextField.delegate = self
        modelTextField.delegate = self
        
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        tapGesture = UITapGestureRecognizer(target: self, action: Selector("dismissKeyboard:"))
        
        //Make image clicable
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("addCarImage:"))
        carImageView.userInteractionEnabled = true
        carImageView.addGestureRecognizer(tapGestureRecognizer)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    //METHODS TO MAKE CONTROLS FLUID
    
    func createInputsFromVehicle() {
        guard let vehicle = self.vehicle else {
            return
        }
        
        makeTextField.text = vehicle.make
        modelTextField.text = vehicle.model
        carImageView.image = UIImage(contentsOfFile: fileInDocumentsDirectory(vehicle.imageName))
        fuelTypeLabel.text = vehicle.fuel
        vehicleFuel = vehicle.fuel
        imageLabel.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == modelTextField {
            textField.resignFirstResponder()
            return true
        }
        modelTextField.becomeFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textFieldHelper = textField
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textFieldHelper = nil
    }
    
    func dismissKeyboard (recognizer: UITapGestureRecognizer) {
        if let textF = textFieldHelper {
            textF.resignFirstResponder()
        }
    }
    
    func setKeyboardHelper() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboard = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(keyboard.CGRectValue().height, duration: animationDuration.doubleValue)
        if let gesture = tapGesture {
            self.view.addGestureRecognizer(gesture)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
        animateToKeyboardHeight(0, duration: animationDuration.doubleValue)
        if let gesture = tapGesture {
            self.view.removeGestureRecognizer(gesture)
        }
    }
    
    func animateToKeyboardHeight(kbHeight: CGFloat, duration: Double) {
        UIView.animateWithDuration(duration, animations: {
            self.tableView.contentInset = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, kbHeight, self.tableView.contentInset.right)
            self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(self.tableView.contentInset.top, self.tableView.contentInset.left, kbHeight, self.tableView.contentInset.right)
        })
    }
    
    //END

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
        addOrReplaceVehicle()
        saveVehicles(vehiclesList, toPath: vehiclesPath!)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func addOrReplaceVehicle() {
        if let newVehicle = createVehicleFromInputs() {
            if vehicle == nil {
                vehiclesList.vehicles.append(newVehicle)
            } else {
                /*if let delegate = self.delegate {
                    delegate.setEditedItem(newItem)
                }*/
                
                for var i = 0; i < vehiclesList.vehicles.count; i++ {
                    if vehicle!.make == vehiclesList!.vehicles[i].make {
                        vehiclesList!.vehicles[i] = newVehicle
                    }
                }
            }
        }
    }
    
    func createVehicleFromInputs() -> Vehicle? {
        var vehicle: Vehicle? = nil
        guard let make = makeTextField.text else {
            return vehicle
        }
        
        guard let model = modelTextField.text else {
            return vehicle
        }
        
        guard let image = carImageView.image else {
            return vehicle
        }
        
        var imageName = randomImageName()+".jpg"
        
        for var i = 0; i < vehiclesList.vehicles.count; i++ {
            if imageName == vehiclesList.vehicles[i].imageName {
                imageName = randomImageName()+".jpg"
                i = 0
            }
        }
        
        vehicle = Vehicle(make: make, model: model, imageName: imageName)
        vehicle!.image = image
        
        if let fuel = vehicleFuel {
            vehicle!.fuel = fuel
        } else {
            vehicle!.fuel = "None"
        }
        
        return vehicle
    }
    
    
    func addCarImage(recognizer: UITapGestureRecognizer) {
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.allowsEditing = true
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        carImageView.image = image
        imageLabel.text = ""
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tableCell = tableView.cellForRowAtIndexPath(indexPath)
            
        for view in tableCell!.contentView.subviews {
            if let textField = view as? UITextField {
                textField.becomeFirstResponder()
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nextView:FuelTypeTableViewController = segue.destinationViewController as? FuelTypeTableViewController {
            nextView.vehicleFuel = vehicleFuel
            nextView.delegate = self
        }
    }
    
    func sendFuel(fuel: String) {
        fuelTypeLabel.text = fuel
        vehicleFuel = fuel
    }
    
    
    //Do not delete
    override func viewWillAppear(animated: Bool) {
        
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
