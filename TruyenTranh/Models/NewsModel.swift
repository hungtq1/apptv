//
//  NewsModel.swift
//  TruyenTranh
//
//  Created by hungtq on 07/04/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class NewsModel: Mappable {
    var news = [News]()
    var success = false
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        news <- map["data"]
        success <- map["success"]
    }
}

class News: Mappable {
    var BoxName = ""
    var BoxNameK = ""
    var BoxType = ""
    var BoxTypeName = ""
    var BoxDescription = ""
    var LastTopicID = ""
    var LastTopicName = ""
    var LastTopicUserPost = ""
    var LastTopicTimePost:Date? = nil
    var BoxPath = ""
    var BoxLevel = 0
    var Topic = 0
    var BaiViet = 0
    var ParentBoxID = 0
    //var Mods = ""
    var BoxDisplay = false
    var BoxDisplayInMain = false
    var Id = ""
    var MongoId = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BoxName <- map["BoxName"]
        BoxNameK <- map["BoxNameK"]
        BoxType <- map["BoxType"]
        BoxTypeName <- map["BoxTypeName"]
        BoxDescription <- map["BoxDescription"]
        LastTopicID <- map["LastTopicID"]
        LastTopicName <- map["LastTopicName"]
        LastTopicUserPost <- map["LastTopicUserPost"]
        LastTopicTimePost <- map["LastTopicTimePost"]
        BoxPath <- map["BoxPath"]
        BoxLevel <- map["BoxLevel"]
        Topic <- map["Topic"]
        BaiViet <- map["BaiViet"]
        ParentBoxID <- map["ParentBoxID"]
        BoxDisplay <- map["BoxDisplay"]
        BoxDisplayInMain <- map["BoxDisplayInMain"]
        Id <- map["Id"]
        MongoId <- map["MongoId"]
    }
}
