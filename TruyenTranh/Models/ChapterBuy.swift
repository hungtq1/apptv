//
//  ChapterBuy.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class ChapterBuy: Mappable {
    var UserID = ""
    var UserName = ""
    var ChapID = ""
    var StoryID = ""
    var TieuDeChap = ""
    var NumberKNB = 0
    var TypeChap = 0
    var NgayMua = ""
    var Id = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        UserID <- map["UserID"]
        UserName <- map["UserName"]
        ChapID <- map["ChapID"]
        StoryID <- map["StoryID"]
        TieuDeChap <- map["TieuDeChap"]
        NumberKNB <- map["NumberKNB"]
        TypeChap <- map["TypeChap"]
        NgayMua <- map["NgayMua"]
        Id <- map["Id"]
    }
}

class ChapterBuyData: Mappable {
    var chapterBuy = [ChapterBuy]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        chapterBuy <- map["data"]
    }
}
