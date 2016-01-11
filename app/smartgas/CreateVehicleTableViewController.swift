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
    var vehiclesList: [Vehicle]!
    let fuelTypes = FuelType.loadAll()
    var fuelId: Int?

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
        carImageView.image = vehicle.image
        imageLabel.text = ""
        let allFuels = FuelType.loadAll()
        for fuel in allFuels {
            if vehicle.fuelId == fuel.id {
                fuelTypeLabel.text = "\(fuel.name)"
                self.fuelId = fuel.id
            }
        }
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

    @IBAction func cancelBarButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveBarButton(sender: UIBarButtonItem) {
        addOrReplaceVehicle()
        Vehicle.saveMany(vehiclesList)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func addOrReplaceVehicle() {
        if let newVehicle = createVehicleFromInputs() {
            if vehicle == nil {
                vehiclesList.append(newVehicle)
            } else {
                /*if let delegate = self.delegate {
                    delegate.setEditedItem(newItem)
                }*/
                
                for var i = 0; i < vehiclesList.count; i++ {
                    if vehicle!.make == vehiclesList[i].make {
                        vehiclesList[i] = newVehicle
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
        
        vehicle = Vehicle(make: make, model: model, image: image, fuelId: self.fuelId ?? 1)
        vehicle!.image = image
        
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
            nextView.fuelTypes = fuelTypes
            nextView.vehicleFuelId = self.fuelId
            nextView.delegate = self
        }
    }
    
    func sendFuelId(fuelId: Int) {
        self.fuelId = fuelId
        for fuelType in fuelTypes {
            if fuelType.id == fuelId {
                fuelTypeLabel.text = fuelType.name
            }
        }
    }
    
    
    //Do not delete
    override func viewWillAppear(animated: Bool) {
        
    }
}
