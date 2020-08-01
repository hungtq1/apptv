//
//  CurrentChap.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class CurrentChap: Mappable {
    
    var chapNumber:Int = 0
    var storyID:String? = nil
    var storyName:String? = nil
    var chapTitle:String? = nil
    var chapContent:String? = nil
    var chapNameK:String? = nil
    var chapStatus:Int = 0
    var chapTags:String? = nil
    var chapPCount:Int = 0
    var chapPostDate:Date? = nil
    var chapLinkDown:String? = nil
    var chapThongBao:String? = nil
    var chapUserPost:String? = nil
    var chapContentVideo:String? = nil
    var chapContentVideoTimeActive:Date? = nil
    var chapPrice:Int = 0
    var totalBuy:Int = 0
    var totalThanks:Int = 0
    var chapterContent2:String? = nil
    var Id:String? = nil
    var mongoId:String? = nil
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        chapNumber <- map["ChapNumber"]
        storyID <- map["StoryID"]
        storyName <- map["StoryName"]
        chapTitle <- map["ChapTitle"]
        chapContent <- map["ChapContent"]
        chapNameK <- map["ChapNameK"]
        chapStatus <- map["ChapStatus"]
        chapTags <- map["ChapTags"]
        chapPCount <- map["ChapPCount"]
        chapPostDate <- map["ChapPostDate"]
        chapLinkDown <- map["ChapLinkDown"]
        chapThongBao <- map["ChapThongBao"]
        chapUserPost <- map["ChapUserPost"]
        chapContentVideo <- map["ChapContentVideo"]
        chapContentVideoTimeActive <- map["ChapContentVideoTimeActive"]
        chapPrice <- map["ChapPrice"]
        totalBuy <- map["TotalBuy"]
        totalThanks <- map["TotalThanks"]
        chapterContent2 <- map["ChapterContent2"]
        Id <- map["Id"]
        mongoId <- map["MongoId"]
    }
}
