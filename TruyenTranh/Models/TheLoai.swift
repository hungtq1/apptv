//
//  TheLoai.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//
import ObjectMapper

class TheLoai: Mappable {
    
    var tenTheLoai:String? = nil
    var gioiThieu:String? = nil
    var displayInMain:Int = 0
    var moTa = ""
    var iD = ""
    var mongoId:String? = nil
    var truyen = [Truyen]()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        tenTheLoai <- map["TenTheLoai"]
        gioiThieu <- map["GioiThieu"]
        displayInMain <- map["DisplayInMain"]
        mongoId <- map["MongoId"]
        moTa <- map["MoTa"]
        iD <- map["ID"]
        truyen <- map["Truyen"]
    }
}
