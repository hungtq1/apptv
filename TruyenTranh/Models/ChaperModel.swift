//
//  ChaperModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class ChaperModel: Mappable {
    var chaper:[Chaper]? = nil
    var listmua:String? = nil
    var vipmember:Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        chaper <- map["list_chap"]
        listmua <- map["listmua"]
        vipmember <- map["vipmember"]
    }
}
