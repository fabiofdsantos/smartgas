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

enum FilterTypes: String {

    case Distance = "Distance"
    case Price = "Price"
    case Smart = "Smart"

    static func allValues() -> [String] {
        return [Distance.rawValue, Price.rawValue, Smart.rawValue]
    }

    static func count() -> Int {
        return allValues().count
    }
}
