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
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet var brandImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setFuelStation (fuelStation: FuelStation, brands: [Brand]) {
        self.titleLabel.text = fuelStation.title
        self.addressLabel.text = fuelStation.address
        self.distanceLabel.text = "...km"
        self.priceLabel.text = "\(fuelStation.prices.values.first!)€"
        
        for brand in brands {
            if(brand.id == fuelStation.brandId) {
                self.brandImage.image = brand.image
            }
        }
    }
    
    func setDistance (distance: String) {
        self.distanceLabel.text = distance + "km"
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
