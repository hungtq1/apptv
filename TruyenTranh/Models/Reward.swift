//
//  Reward.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class Reward: Mappable {
    var success:Bool? = false
    var data:Any? = nil

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}
