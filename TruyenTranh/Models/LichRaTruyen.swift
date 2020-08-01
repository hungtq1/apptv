//
//  LichRaTruyen.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class LichRaTruyen: Mappable {
    var time = ""
    var tentruyen = ""
    var idstory = ""
    var storynamek = ""
    var ispast = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        time <- map["time"]
        tentruyen <- map["tentruyen"]
        idstory <- map["idstory"]
        storynamek <- map["storynamek"]
        ispast <- map["ispast"]
    }
}
