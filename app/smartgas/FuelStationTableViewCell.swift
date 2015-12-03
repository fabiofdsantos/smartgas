//
//  FuelStationTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 03/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class FuelStationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var districtLabel: UILabel!
    
    
    func setFuelStation (fuelStation: FuelStation) {
        self.titleLabel.text = fuelStation.title
        self.addressLabel.text = fuelStation.address
        self.districtLabel.text = "\(fuelStation.districtId)"
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
