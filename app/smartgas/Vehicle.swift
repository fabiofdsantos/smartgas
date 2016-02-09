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

class Vehicle: NSObject, NSCoding {
    var make: String
    var model: String
    var mileageKm: Float?
    var consume: Float?
    var image: UIImage?
    var fuelId: Int?

    init(make: String, model: String, image: UIImage, fuelId: Int){
        self.make = make
        self.model = model
        self.image = image
        self.fuelId = fuelId
    }

    struct Const {
        static let make = "make"
        static let model = "model"
        static let mileageKm = "mileageKm"
        static let consume = "consume"
        static let image = "image"
        static let fuelId = "fuelId"
    }

    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(make, forKey: Const.make)
        coder.encodeObject(model, forKey: Const.model)
        coder.encodeFloat(mileageKm ?? 0.0, forKey: Const.mileageKm)
        coder.encodeFloat(consume ?? 0.0, forKey: Const.consume)
        coder.encodeObject(image, forKey: Const.image)
        coder.encodeInteger(fuelId ?? 0, forKey: Const.fuelId)
    }

    required init?(coder decoder: NSCoder) {
        self.make = decoder.decodeObjectForKey(Const.make) as! String
        self.model = decoder.decodeObjectForKey(Const.model) as! String
        self.mileageKm = decoder.decodeObjectForKey(Const.mileageKm) as? Float ?? 0.0
        self.consume = decoder.decodeObjectForKey(Const.consume) as? Float ?? 0.0
        self.fuelId = decoder.decodeIntegerForKey(Const.fuelId)
        self.image = decoder.decodeObjectForKey(Const.image) as? UIImage
    }

    static func saveMany (brands: [Vehicle]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])

        let filePath = documentsPath.URLByAppendingPathComponent("Vehicles.data")

        let path = filePath.path!

        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }

        return false
    }

    static func loadAll() -> [Vehicle] {
        var dataToRetrieve = [Vehicle]()

        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Vehicles.data", isDirectory: false)

        let path = filePath.path!

        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Vehicle] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }


}
