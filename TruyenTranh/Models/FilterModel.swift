//
//  FilterModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/18/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class FilterModel: Mappable {
    var success = false
    var data = [StoryOfCategory]()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}
