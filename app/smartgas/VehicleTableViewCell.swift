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
        self.vehicleImageView.image = vehicle.image
        self.makeModelLabel.text = vehicle.make + " " + vehicle.model
        let allFuels = FuelType.loadAll()
        for fuel in allFuels {
            if vehicle.fuelId == fuel.id {
                self.fuelLabel.text = "\(fuel.name)"
            }
        }
        self.consumeLabel.text = "0"
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
