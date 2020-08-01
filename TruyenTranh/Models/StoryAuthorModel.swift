//
//  StoryAuthorModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/20/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class StoryAuthorModel: Mappable {
    var info:StoryAuthor? = nil
    var story = [Story]()
    var urlimage:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        info <- map["info"]
        story <- map["truyen"]
        urlimage <- map["urlimage"]
    }
}
