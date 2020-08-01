//
//  Story.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StorySearch: Mappable {
    var truyen = [Story]()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        truyen <- map["truyen"]
    }
}

class Story: Mappable {
    var Id:String? = nil
    var menuID:Int = 0
    var storyImage:String? = nil
    var storyName:String? = nil
    var storyDescription:String? = nil
    var storyOtherName:String? = nil
    var storyUpdateTime:Date? = nil
    var storyUpdateTimeTick:Date? = nil
    var isDisplay:Int = 0
    var isFull:Int = 0
    var isKhuyenKhichDoc:Int = 0
    var storyLastChap:Int = 0
    var storyTitleLastChap:String? = nil
    var starRate:Float = 0.0
    var storyMark:Float = 0.0
    var storyView:Int = 0
    var numberUserFollow:Int = 0
    var storyTheLoai:[TheLoai]? = nil
    var storyAuthor:[StoryAuthor]? = nil
    var storyNhomDich:[StoryNhomDich]? = nil
    var StoryNameK = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        Id <- map["Id"]
        menuID <- map["MenuID"]
        storyImage <- map["StoryImage"]
        storyName <- map["StoryName"]
        storyDescription <- map["StoryDescription"]
        storyOtherName <- map["StoryOtherName"]
        storyUpdateTime <- (map["StoryUpdateTime"],DateFormatterTransform(dateFormatter:dateFormatter))
        storyUpdateTimeTick <- (map["StoryUpdateTimeTick"],DateFormatterTransform(dateFormatter:dateFormatter))
        isDisplay <- map["IsDisplay"]
        isFull <- map["IsDisplay"]
        isKhuyenKhichDoc <- map["IsKhuyenKhichDoc"]
        storyLastChap <- map["StoryLastChap"]
        storyTitleLastChap <- map["StoryTitleLastChap"]
        starRate <- map["StarRate"]
        storyMark <- map["StoryMark"]
        storyView <- map["StoryView"]
        numberUserFollow <- map["NumberUserFollow"]
        storyTheLoai <- map["StoryTheLoai"]
        storyAuthor <- map["StoryAuthor"]
        storyNhomDich <- map["StoryNhomDich"]
        StoryNameK <- map["StoryNameK"]
    }
}
