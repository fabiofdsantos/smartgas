//
// This file is part of SmartGas, an iOS app to find the best gas station nearby.
//
// (c) Fábio Santos <ffsantos92@gmail.com>
// (c) Mateus Silva <mateusgsilva_@hotmail.com>
// (c) Fábio Marques <fabio1956.epo@gmail.com>
//
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code.
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
