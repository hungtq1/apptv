//
//  StoryModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StoryModel: Mappable {
    var story:Story? = nil
    var review:Review? = nil
    var firstchap:Firstchap? = nil
    var relatedStories = [Truyen]()
    var urlimage:String? = nil
    var isTheoDoi:Int = 0
    var urluser:String? = nil
    var numcomment:Int = 0
    var numberReview:Int = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        story <- map["story"]
        review <- map["review"]
        firstchap <- map["firstchap"]
        relatedStories <- map["truyenlienquan"]
        urlimage <- map["urlimage"]
        isTheoDoi <- map["isTheoDoi"]
        urluser <- map["urluser"]
        numcomment <- map["numcomment"]
        numberReview <- map["numberReview"]
    }
    
    public static func ==(lhs: StoryModel, rhs: StoryModel) -> Bool{
        return
            lhs.numcomment == rhs.numcomment &&
            lhs.numberReview == rhs.numberReview &&
            lhs.urluser == rhs.urluser &&
            lhs.isTheoDoi == rhs.isTheoDoi &&
            lhs.story?.storyName == rhs.story?.storyName
    }
}
