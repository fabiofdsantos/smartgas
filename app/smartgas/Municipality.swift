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

import Foundation

class Municipality: NSObject, NSCoding {
    var id: Int!
    var name: String!
    var districtId: Int!

    init(id: Int, name: String, districtId: Int) {
        self.id = id
        self.name = name
        self.districtId = districtId
    }

    struct Const {
        static let id = "id"
        static let name = "name"
        static let districtId = "districtId"
    }

    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
        coder.encodeInteger(districtId, forKey: Const.districtId)
    }

    required init?(coder decoder: NSCoder) {
        id = decoder.decodeIntegerForKey(Const.id)
        name = decoder.decodeObjectForKey(Const.name) as! String
        districtId = decoder.decodeIntegerForKey(Const.districtId)
    }

    static func saveMany (brands: [Municipality]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])

        let filePath = documentsPath.URLByAppendingPathComponent("Municipalities.data")

        let path = filePath.path!

        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }

        return false
    }

    static func loadAll() -> [Municipality] {
        var dataToRetrieve = [Municipality]()

        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Municipalities.data", isDirectory: false)

        let path = filePath.path!

        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [Municipality] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }



}
