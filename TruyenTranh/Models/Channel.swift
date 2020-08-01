//
//  Channel.swift
//  BangoohTivi
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper


class DataChannel: Mappable {
    
    var channels = [Channel]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}

class Channel: Mappable {
    
    var id = ""
    var icon_url = ""
    var content = ""
    var channel_name = ""
    var channel_url = ""
    var description = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        icon_url <- map["icon_url"]
        content <- map["content"]
        channel_name <- map["channel_name"]
        channel_url <- map["channel_url"]
        description <- map["description"]
    }
}
