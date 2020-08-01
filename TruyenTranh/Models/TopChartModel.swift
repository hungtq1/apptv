//
//  TopChartModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/14/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class TopChartModel: Mappable {
    var success = false
    var data = [TopCharts]()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}
