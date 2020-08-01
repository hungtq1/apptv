//
//  UserLevel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class UserLevel: Mappable {
    
    var soThuTu:Int = 0
    var dangCapName:String? = nil
    var triKinhNghiem:Int = 0
    var congHienYeuCau:Int = 0
    var Id:String? = nil
    var mongoId:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        soThuTu <- map["SoThuTu"]
        dangCapName <- map["DangCapName"]
        triKinhNghiem <- map["TriKinhNghiem"]
        congHienYeuCau <- map["CongHienYeuCau"]
        Id <- map["Id"]
        mongoId <- map["MongoId"]
    }
}
