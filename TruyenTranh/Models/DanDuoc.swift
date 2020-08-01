//
//  DanDuoc.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/12/20.
//  Copyright © 2020 Truyen. All rights reserved.
//
import ObjectMapper

class DanDuoc: Mappable {
    var LoaiPhapBao = 0
    var TenPhapBao = ""
    var HinhAnh = ""
    var Gia = 0
    var MoTa = ""
    var LoaiDanDuoc = ""
    var Id = ""
    var DangCapYeuCau = DangCap()

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        LoaiPhapBao <- map["LoaiPhapBao"]
        TenPhapBao <- map["TenPhapBao"]
        HinhAnh <- map["HinhAnh"]
        Gia <- map["Gia"]
        MoTa <- map["MoTa"]
        LoaiDanDuoc <- map["LoaiDanDuoc"]
        Id <- map["Id"]
        DangCapYeuCau <- map["DangCapYeuCau"]
    }
}
