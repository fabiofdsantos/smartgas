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

class VehiclesList: NSObject, NSCoding {

    var vehicles: [Vehicle]
    let vehiclesKey = "vehicles"

    // MARK: - Initializers

    override init() {
        vehicles = [Vehicle]()
        super.init()
    }

    // MARK: - NSCoding
    required init(coder decoder: NSCoder) {
        vehicles = decoder.decodeObjectForKey(vehiclesKey) as! [Vehicle]
        super.init()
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(vehicles, forKey: vehiclesKey)
    }
}
