//
//  Review.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class Review: Mappable {
    var reviewRate = 0
    var userName:String? = nil
    var reviewDate:Date? = nil
    var userImage:String? = nil
    var reviewContent:String? = nil
    var userID:String? = nil
    var reviewStoryID:String? = nil
    var reviewStoryName:String? = nil
    var reviewStatus:Int = 0
    var reviewLink:String? = nil
    var Id:String? = nil
    var likeCount:Int = 0
    var mongoId:String? = nil
    //"LikeUser": [],
                
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        reviewRate <- map["ReviewRate"]
        userName <- map["UserName"]
        reviewDate <- (map["ReviewDate"],DateFormatterTransform(dateFormatter:dateFormatter))
        userImage <- map["UserImage"]
        reviewContent <- map["ReviewContent"]
        userID <- map["UserID"]
        reviewStoryID <- map["ReviewStoryID"]
        reviewStoryName <- map["ReviewStoryName"]
        reviewStatus <- map["ReviewStatus"]
        reviewLink <- map["ReviewLink"]
        likeCount <- map["LikeCount"]
        Id <- map["Id"]
        mongoId <- map["MongoId"]
    }
}
