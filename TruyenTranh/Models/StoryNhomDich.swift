//
//  StoryNhomDich.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StoryNhomDich: Mappable {
    var _id:String? = nil
    var mongoId:String? = nil
    var tenNhomDich:String? = nil
    var avatar:String? = nil
    var leader:String? = nil
    var mailCuaNhom:String? = nil
    var story:[Story]? = nil
   // var DSThanhVien
    var capdobanghoi:Int = 0
    var status:Int = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        _id <- map["_id"]
        mongoId <- map["MongoId"]
        tenNhomDich <- map["TenNhomDich"]
        avatar <- map["Avatar"]
        leader <- map["Leader"]
        mailCuaNhom <- map["MailCuaNhom"]
        story <- map["story"]
        capdobanghoi <- map["Capdobanghoi"]
        status <- map["Status"]
    }
}
