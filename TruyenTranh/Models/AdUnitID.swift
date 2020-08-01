//
//  AdUnitID.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class AdUnitID: Mappable {
    var success:Bool? = false
    var data:AdUnit? = nil

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}

class AdUnit: Mappable {
    var admod:String? = nil
    var facebook:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        admod <- map["admod"]
        facebook <- map["facebook"]
    }
}


