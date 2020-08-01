//
//  CustomPopoverSettings.swift
//  TruyenTranh
//
//  Created by hungtq on 5/16/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class ReportChapterError: Mappable {
    var success = false
    var data:Any? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}
