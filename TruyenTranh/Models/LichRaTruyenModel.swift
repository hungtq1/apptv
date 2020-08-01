//
//  LichRaTruyenModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/13/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class LichRaTruyenModel: Mappable {
    var lichRaTruyen = [LichRaTruyen]()
    var success = false
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        lichRaTruyen <- map["data"]
        success <- map["success"]
    }
}
