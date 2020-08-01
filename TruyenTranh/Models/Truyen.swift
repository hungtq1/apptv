//
//  Truyen.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/4/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import ObjectMapper

class Truyen: Mappable {
    
    var storyImage:String? = nil
    var storyName:String? = nil
    var storyTitleLastChap:String? = nil
    var storyID:String? = nil
    var storyUpdateTime:String? = nil
    var storyNameK:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        storyImage <- map["StoryImage"]
        storyName <- map["StoryName"]
        storyTitleLastChap <- map["StoryTitleLastChap"]
        storyID <- map["StoryID"]
        storyUpdateTime <- map["StoryUpdateTime"]
        storyNameK <- map["StoryNameK"]
    }
}
