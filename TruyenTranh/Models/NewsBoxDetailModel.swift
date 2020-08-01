//
//  NewsBoxDetailModel.swift
//  TruyenTranh
//
//  Created by hungtq on 07/04/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class NewsBoxDetailModel: Mappable {
    var listNews:ListNews? = nil
    var success = false
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        listNews <- map["data"]
        success <- map["success"]
    }
}
