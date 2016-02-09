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

class FuelType: NSObject, NSCoding {
    var id: Int!
    var name: String!
    var selected: Bool!

    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.selected = true
    }

    struct Const {
        static let id = "id"
        static let name = "name"
        static let selected = "selected"
    }

    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
        coder.encodeBool(selected, forKey: Const.selected)
    }

    required init?(coder decoder: NSCoder) {
        id = decoder.decodeIntegerForKey(Const.id)
        name = decoder.decodeObjectForKey(Const.name) as! String
        selected = decoder.decodeBoolForKey(Const.selected)
    }

    static func saveMany (brands: [FuelType]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])

        let filePath = documentsPath.URLByAppendingPathComponent("FuelTypes.data")

        let path = filePath.path!

        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }

        return false
    }

    static func loadAll() -> [FuelType] {
        var dataToRetrieve = [FuelType]()

        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("FuelTypes.data", isDirectory: false)

        let path = filePath.path!

        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [FuelType] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}
