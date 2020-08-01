//
//  ListTheLoai.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class ListTheLoai: Mappable {
    
    var menuID = 0
    var storyName:String? = nil
    var storyImage:String? = nil
    var storyUpdateTime:Date? = nil
    var storyTitleLastChap:String? = nil
    var storyNameK:String? = nil
    var nameKLastChap:String? = nil
    var storyView = 0
    var storyTrangChuType = 0
    var isKhuyenKhichDoc = 0
    var storyDescription:String? = nil
    var id:String? = nil
    var mongoId:String? = nil
    var isDisplay:Int = 0
    var isFull:Int = 0
    var storyLastChap:Int = 0
    var storyTheLoai:[TheLoai]? = nil
    var storyAuthor:[StoryAuthor]? = nil
    var storyNhomDich:[StoryNhomDich]? = nil
    var starRate:Float = 0.0
    var storyMark:Float = 0.0
//    "ListUserRate":[
//    ],
//
    var keyword:String? = nil
    var numberUserFollow:Int = 0
    var storyCreateID:String? = nil
    var storyCreateType:String? = nil
    var storyViewInDay:Int = 0
    var tags:String? = nil
    var storyViewInWeek:Int = 0
    var isCraw:Int = 0
    var urlCraw:String? = nil
    var priceChap:Int = 0
    
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
        
        isDisplay <- map["IsDisplay"]
        isFull <- map["IsFull"]
        storyLastChap <- map["StoryLastChap"]
        
        storyTheLoai <- map["StoryTheLoai"]
        storyAuthor <- map["StoryAuthor"]
        storyNhomDich <- map["StoryNhomDich"]
        starRate <- map["StarRate"]
        storyMark <- map["StoryMark"]
        
        keyword <- map["Keyword"]
        numberUserFollow <- map["NumberUserFollow"]
        storyCreateID <- map["StoryCreateID"]
        storyCreateType <- map["StoryCreateType"]
        storyViewInDay <- map["StoryViewInDay"]
        tags <- map["Tags"]
        storyViewInWeek <- map["StoryNameK"]
        isCraw <- map["IsCraw"]
        urlCraw <- map["UrlCraw"]
        priceChap <- map["PriceChap"]
    }
}
