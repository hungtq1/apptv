//
//  MoiCapNhat.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class MoiCapNhat: Mappable {
    
    var menuID = 0
    var storyName:String? = nil
    var storyImage:String? = nil
    var storyUpdateTime:Date? = nil
    var storyTitleLastChap:String? = nil
    var storyNameK:String? = nil
    var nameKLastChap = ""
    var storyView = 0
    var storyTrangChuType = 0
    var isKhuyenKhichDoc = 0
    var storyDescription = ""
    var id:String? = nil
    var mongoId:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        menuID <- map["MenuID"]
        storyName <- map["StoryName"]
        storyImage <- map["StoryImage"]
        storyUpdateTime <- map["StoryUpdateTime"]
        storyTitleLastChap <- map["StoryTitleLastChap"]
        storyNameK <- map["StoryNameK"]
        nameKLastChap <- map["NameKLastChap"]
        storyView <- map["StoryView"]
        storyTrangChuType <- map["StoryTrangChuType"]
        isKhuyenKhichDoc <- map["IsKhuyenKhichDoc"]
        storyDescription <- map["StoryDescription"]
        id <- map["Id"]
        mongoId <- map["MongoId"]
    }
}
