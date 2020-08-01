//
//  TopCharts.swift
//  TruyenTranh
//
//  Created by hungtq on 5/14/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class TopCharts: Mappable {
    
    var image:String? = nil
    var stt:Int = 0
    var title_head:String? = nil
    var title_small:String? = nil
  
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        image <- map["image"]
        stt <- map["stt"]
        title_head <- map["title_head"]
        title_small <- map["title_small"]
    }
}
