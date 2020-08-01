//
//  HistoryLinhThach.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class HistoryLinhThach: Mappable {
    var UserID = ""
    var UserName = ""
    var Key_Trans = ""
    var maseri = ""
    var SoTien = 0
    var Status = 0
    var TypeCharge = 0
    var NgayNap = ""
    var Id = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        UserID <- map["UserID"]
        UserName <- map["UserName"]
        Key_Trans <- map["Key_Trans"]
        maseri <- map["maseri"]
        SoTien <- map["SoTien"]
        Status <- map["Status"]
        TypeCharge <- map["TypeCharge"]
        NgayNap <- map["NgayNap"]
        Id <- map["Id"]
    }
}

class HistoryLinhThachData: Mappable {
    var historyLinhThach = [HistoryLinhThach]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        historyLinhThach <- map["data"]
    }
}

