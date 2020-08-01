//
//  TheoDoi.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class DataStoryTheoDoi: Mappable {
    var theodoi = [StoryTheoDoi]()
    var urlimage:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        theodoi <- map["theodoi"]
        urlimage <- map["urlimage"]
    }
}

class StoryTheoDoi: Mappable {
    var StoryID:String? = nil
    var UserName = ""
    var StoryUpdateTime = ""
    var IsNhanThongBao = false
    var MenuID = 0
    var Status = 0
    var StoryName:String? = nil
    var StoryNameK = ""
    var NameKLastChap = ""
    var StoryTitleLastChap:String? = nil
    var StoryImage:String? = nil
    var UserID = ""
    var Id = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        StoryID <- map["StoryID"]
        UserName <- map["UserName"]
        StoryUpdateTime <- map["StoryUpdateTime"]
        IsNhanThongBao <- map["IsNhanThongBao"]
        MenuID <- map["MenuID"]
        Status <- map["Status"]
        StoryName <- map["StoryName"]
        StoryNameK <- map["StoryNameK"]
        NameKLastChap <- map["NameKLastChap"]
        StoryTitleLastChap <- map["StoryTitleLastChap"]
        StoryImage <- map["StoryImage"]
        UserID <- map["UserID"]
        Id <- map["Id"]
    }
}
