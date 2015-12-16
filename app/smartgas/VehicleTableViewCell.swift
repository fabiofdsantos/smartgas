//
//  VehicleTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 26/11/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class VehicleTableViewCell: UITableViewCell {
    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var makeModelLabel: UILabel!
    @IBOutlet weak var fuelLabel: UILabel!
    @IBOutlet weak var consumeLabel: UILabel!
    
    func setVehicle (vehicle:Vehicle) {
        let imagePath = fileInDocumentsDirectory(vehicle.imageName)
        self.vehicleImageView.image = UIImage(contentsOfFile: imagePath)
        self.makeModelLabel.text = vehicle.make + " " + vehicle.model
        self.fuelLabel.text = vehicle.fuel
        self.consumeLabel.text = "\(vehicle.consume)"
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
