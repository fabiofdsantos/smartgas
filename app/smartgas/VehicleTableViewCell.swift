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
