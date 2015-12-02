//
//  FuelTypeTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 02/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class FuelTypeTableViewCell: UITableViewCell {

    @IBOutlet weak var fuelTypeLabel: UILabel!
    
    func setFuel (fuel: String) {
        self.fuelTypeLabel.text = fuel
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
