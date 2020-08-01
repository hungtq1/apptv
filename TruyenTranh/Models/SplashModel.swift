//
//  SplashModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/21/20.
//  Copyright © 2020 hung. All rights reserved.
//
import ObjectMapper

class SplashModel: Mappable {
    var success:Bool? = false
    var splash = Splash()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        splash <- map["data"]
        success <- map["success"]
    }
}

class Splash: Mappable {
    var danhsach:[String:Any]? = nil
//    var hinhanh:String? = nil
//    var type = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        danhsach <- map["danhsach"]
//        hinhanh <- map["danhsach"]["hinhanh"]
//        type <- map["danhsach"]["type"]
    }
}
