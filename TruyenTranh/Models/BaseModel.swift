//
//  BaseModel.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/5/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    var success = false
    var data = CategoryModel()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}
