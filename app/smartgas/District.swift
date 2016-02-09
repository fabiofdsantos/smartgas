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

class District: NSObject, NSCoding {
    var id: Int!
    var name: String!
    var municipalityId: Int!

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

    struct Const {
        static let id = "id"
        static let name = "name"
    }

    // MARK: NSCoding
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(id, forKey: Const.id)
        coder.encodeObject(name, forKey: Const.name)
    }

    required init?(coder decoder: NSCoder) {
        id = decoder.decodeIntegerForKey(Const.id)
        name = decoder.decodeObjectForKey(Const.name) as! String
    }

    static func saveMany (brands: [District]) -> Bool {
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])

        let filePath = documentsPath.URLByAppendingPathComponent("Districts.data")

        let path = filePath.path!

        if NSKeyedArchiver.archiveRootObject(brands, toFile: path) {
            return true
        }

        return false
    }

    static func loadAll()  -> [District] {
        var dataToRetrieve = [District]()

        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
        let filePath = documentsPath.URLByAppendingPathComponent("Districts.data", isDirectory: false)

        let path = filePath.path!

        if let newData = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? [District] {
            dataToRetrieve = newData
        }
        return dataToRetrieve
    }
}
