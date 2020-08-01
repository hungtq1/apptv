//
//  DownloadChapModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/19/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class DownloadChapModel: Mappable {
    var success = false
    var data = DownloadChap()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        success <- map["success"]
        data <- map["data"]
    }
}

class DownloadChap: Mappable {
    var listlink:[String]?=nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        listlink <- map["listlink"]
    }
}
