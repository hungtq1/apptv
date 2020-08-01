//
//  Chaper.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class Chaper: Mappable {
    var iChapVip:Int = 1
    var Id:String? = nil
    var name:String? = nil
    var isBuy:Int = 0
    //var isSelected = false
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        iChapVip <- map["iChapVip"]
        Id <- map["Id"]
        name <- map["Name"]
        isBuy <- map["isBuy"]
    }
}
