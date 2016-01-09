//
//  FuelStationLocationTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 09/01/16.
//  Copyright © 2016 Mateus Silva. All rights reserved.
//

import UIKit

class FuelStationLocationTableViewCell: UITableViewCell {
    @IBOutlet weak var districtLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
