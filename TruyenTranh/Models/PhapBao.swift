//
//  PhapBao.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 6/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class PhapBaoUser: Mappable {
    var phapBao = [PhapBao]()
    var thanhVien = UserProfile()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        phapBao <- map["pb"]
        thanhVien <- map["tv"]
    }
}

class PhapBao: Mappable {
    var IDThanhVien = ""
    var IDVatPham = ""
    var Id = ""
    var SoLuong = 0
    var TenVatPham = ""
    var DangCapYeuCau = DangCap()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        IDThanhVien <- map["IDThanhVien"]
        IDVatPham <- map["IDVatPham"]
        Id <- map["Id"]
        SoLuong <- map["SoLuong"]
        TenVatPham <- map["TenVatPham"]
        DangCapYeuCau <- map["DangCapYeuCau"]
    }
}
