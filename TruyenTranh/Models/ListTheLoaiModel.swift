//
//  ListTheLoaiModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class ListTheLoaiModel: Mappable {
    var listTheLoai = [ListTheLoai]()
    var uriimage = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        listTheLoai <- map["list"]
        uriimage <- map["uriimage"]
    }
}
