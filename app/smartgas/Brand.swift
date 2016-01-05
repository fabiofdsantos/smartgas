//
//  Brand.swift
//  smartgas
//
//  Created by Mateus Silva on 30/12/15.
//  Copyright © 2015 Mateus Silva. All rights reserved.
//

import UIKit

class Brand: NSObject, NSCoding {
    var id: Int!
    var name: String!
    
    //Constructors
    init(id: Int, name: String){
        self.id = id
        self.name = name
    }
    
    override init() {
        id = 0
        name = ""
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        id = decoder.decodeObjectForKey("id") as! Int
        name = decoder.decodeObjectForKey("name") as! String
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(id, forKey: "id")
        coder.encodeObject(name, forKey: "name")
    }
}