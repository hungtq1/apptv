//
//  PurchaseStoryModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/28/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class PurchaseStoryModel: Mappable {
    var success = false
    var data = PurchaseStory()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}

class PurchaseStory: Mappable {
    var message:String? = nil
    var contentvip:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        message <- map["message"]
        contentvip <- map["contentvip"]
    }
}
