//
//  CategoryModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class CategoryModel: Mappable {
    var gallery = [Gallery]()
    var theLoai = [TheLoai]()
    var moiCapNhat = [MoiCapNhat]()
    
    var theodoichuadoc = 0
    var thongbaomoi = 0
    var version = ""
    var version_number = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        gallery <- map["gallery"]
        theLoai <- map["theloai"]
        moiCapNhat <- map["moicapnhat"]
        theodoichuadoc <- map["theodoichuadoc"]
        thongbaomoi <- map["thongbaomoi"]
        version <- map["version"]
        version_number <- map["version_number"]
    }
}
