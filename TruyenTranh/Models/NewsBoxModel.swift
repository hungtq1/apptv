//
//  NewsBoxModel.swift
//  TruyenTranh
//
//  Created by hungtq on 07/04/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class NewsBoxModel: Mappable {
    var newsBox:NewsBox? = nil
    var success = false
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        newsBox <- map["data"]
        success <- map["success"]
    }
}

class NewsBox: Mappable {
    var listNews = [ListNews]()
    var urlimage = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        listNews <- map["listtin"]
        urlimage <- map["urlimage"]
    }
}
