//
//  ReviewModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//
import ObjectMapper

class ReviewModel: Mappable {
    var reviews = [Review]()
    var uriimage:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        reviews <- map["list"]
        uriimage <- map["uriimage"]
    }
}
