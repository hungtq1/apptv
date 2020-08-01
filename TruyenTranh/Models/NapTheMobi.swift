//
//  NapTheMobi.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/17/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class NapTheMobi: Mappable {
    var cardAmount = 0
    var message = ""
    var status = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        cardAmount <- map["cardAmount"]
        message <- map["message"]
        status <- map["status"]
    }
}

