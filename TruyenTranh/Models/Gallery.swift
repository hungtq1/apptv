//
//  Gallery.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class Gallery: Mappable {
    
    var image:String? = nil
    var idTruyen = ""
    var tenTruyen = ""
    var typeID = ""
    var dateUpdate = ""
    var Id = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        image <- map["Image"]
        idTruyen <- map["IDTruyen"]
        tenTruyen <- map["TenTruyen"]
        typeID <- map["TypeID"]
        dateUpdate <- map["DateUpdate"]
        Id <- map["Id"]
    }
}

