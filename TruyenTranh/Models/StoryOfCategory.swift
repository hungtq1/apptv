//
//  StoryOfCategory.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StoryOfCategory: Mappable {
    
    var Id:String? = nil
    var name:String? = nil
    var type:Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Id <- map["Id"]
        name <- map["Name"]
        type <- map["type"]
    }
}
