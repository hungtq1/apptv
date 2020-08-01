//
//  StoryAuthor.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StoryAuthor: Mappable {
    
    var Id:String? = nil
    var mongoId:String? = nil
    var tenTacGia:String? = nil
    var gioiThieu:String? = nil
    var hinhAnh:String? = nil
    var story:[Story]? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Id <- map["Id"]
        mongoId <- map["MongoId"]
        tenTacGia <- map["TenTacGia"]
        gioiThieu <- map["GioiThieu"]
        hinhAnh <- map["HinhAnh"]
        story <- map["Stories"]
    }
}
