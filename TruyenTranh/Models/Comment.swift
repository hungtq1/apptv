//
//  Comment.swift
//  TruyenTranh
//
//  Created by hungtq on 5/12/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class Comment: Mappable {
    var storyID:String? = nil
    var storyName:String? = nil
    var typeID:Int = 0
    var linkUrl:String? = nil
    var userNameComment:String? = nil
    var userIdComment:String? = nil
    var idCommentParent:String? = nil
    var commentDatePost:Date? = nil
    var commentContent:String? = nil
    var userLevel:UserLevel? = nil
    var userAvatar:String? = nil
    var userType:Int = 0
    var danhHieu:String? = nil
    var Id:String? = nil
    var mongoId:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        storyID <- map["StoryID"]
        storyName <- map["StoryName"]
        typeID <- map["TypeID"]
        linkUrl <- map["LinkUrl"]
        userNameComment <- map["UserNameComment"]
        userIdComment <- map["UserIdComment"]
        idCommentParent <- map["IdCommentParent"]
        commentDatePost <- (map["CommentDatePost"],DateFormatterTransform(dateFormatter:dateFormatter))
        commentContent <- map["CommentContent"]
        userLevel <- map["UserLevel"]
        userAvatar <- map["UserAvatar"]
        userType <- map["UserType"]
        danhHieu <- map["DanhHieu"]
        Id <- map["Id"]
        mongoId <- map["MongoId"]
    }
}
