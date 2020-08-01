//
//  ListNews.swift
//  TruyenTranh
//
//  Created by hungtq on 07/04/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class ListNews: Mappable {
    var BoxID = ""
    var BoxName = ""
    var TenTin = ""
    var TenTinK = ""
    var image = ""
    var TomTat = ""
    var Chitiet = ""
    var NgayGio:Date? = nil
    var TacGia = ""
    var Active = 0
    var ActiveInMain = 0
    var Hot = 0
    var Tag = ""
    var LikeCount = 0
    var Count = 0
    var userPost:UserPost? = nil
    var Id = ""
    var MongoId = ""
   
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        BoxID <- map["BoxID"]
        BoxName <- map["BoxName"]
        TenTin <- map["TenTin"]
        TenTinK <- map["TenTinK"]
        image <- map["Anh"]
        TomTat <- map["TomTat"]
        Chitiet <- map["Chitiet"]
        NgayGio <- map["NgayGio"]
        TacGia <- map["TacGia"]
        Active <- map["Active"]
        ActiveInMain <- map["ActiveInMain"]
        Hot <- map["Hot"]
        Tag <- map["Tag"]
        LikeCount <- map["LikeCount"]
        Count <- map["Count"]
        userPost <- map["UserPost"]
        Id <- map["Id"]
        MongoId <- map["MongoId"]
    }
}

class UserPost: Mappable {
    var UserID = ""
    var Email = ""
    var UserName = ""
    var Avatar = ""
    var UserType = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        UserID <- map["UserID"]
        Email <- map["Email"]
        UserName <- map["UserName"]
        Avatar <- map["Avatar"]
        UserType <- map["UserType"]
    }
}
