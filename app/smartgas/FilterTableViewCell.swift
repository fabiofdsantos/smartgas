//
//  FilterTableViewCell.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterTypeLabel: UILabel!
    
    func setFilter (filter: String) {
        self.filterTypeLabel.text = filter
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
