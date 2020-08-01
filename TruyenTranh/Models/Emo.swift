//
//  LichRaTruyen.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class EmoModel: Mappable {
    var success:Bool? = false
    var emo = Emo()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        emo <- map["data"]
        success <- map["success"]
    }
}

class Emo: Mappable {
    var urlEmoImage:String? = nil
    var EmoVietTat = ""
    var Description = ""
    var Group = ""
    var Id = 0
    var MongoId = 0
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        urlEmoImage <- map["UrlEmoImage"]
        EmoVietTat <- map["EmoVietTat"]
        Description <- map["Description"]
        Id <- map["Id"]
        MongoId <- map["MongoId"]
    }
}
