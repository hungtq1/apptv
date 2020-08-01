//
//  UserProfile.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/13/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class UserProfile: Mappable {
    
    var Email = ""
    var DisplayName = ""
    var BirthDay = ""
    var Gender = ""
    var Address = ""
    var Phone = ""
    var Dangcap = DangCap()
    var KinhNghiem = 0
    var TotalKinhNghiem = 0
    var Active = 0
    var DanhHieu = ""
    var LinhThach = 0
    var Avatar = ""
    var UserName = ""
    var CongHien = 0
    var SoTruyenTheoDoi = 0
    var UserType = 0
    var NhomDich = ""
    var NhomDichID = ""
    var LinhThu = [String]()
    var PhapBao = [String]()
    var ThongBao = 0
    var DateVip = ""
    
    var Wallpaper = ""
    var IsVipMember = false
    var SoLanClickQuangCao = 0
    var thongTinCaNhan = ThongTinCaNhan()
    var Thanks = 0
    var NumberKNB = 0
    var TotalChiTieu = 0
    var Id = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        Email <- map["Email"]
        DisplayName <- map["DisplayName"]
        BirthDay <- map["BirthDay"]
        Gender <- map["Gender"]
        Address <- map["Address"]
        Phone <- map["Phone"]
        Dangcap <- map["DangCap"]
        KinhNghiem <- map["KinhNghiem"]
        TotalKinhNghiem <- map["TotalKinhNghiem"]
        Active <- map["Active"]
        DanhHieu <- map["DanhHieu"]
        LinhThach <- map["LinhThach"]
        Avatar <- map["Avatar"]
        UserName <- map["UserName"]
        CongHien <- map["CongHien"]
        SoTruyenTheoDoi <- map["SoTruyenTheoDoi"]
        UserType <- map["UserType"]
        NhomDich <- map["NhomDich"]
        NhomDichID <- map["NhomDichID"]
        LinhThu <- map["LinhThu"]
        PhapBao <- map["PhapBao"]
        ThongBao <- map["ThongBao"]
        DateVip <- map["DateVip"]
        
        Wallpaper <- map["Wallpaper"]
        IsVipMember <- map["IsVipMember"]
        SoLanClickQuangCao <- map["SoLanClickQuangCao"]
        thongTinCaNhan <- map["ThongTinCaNhan"]
        Thanks <- map["Thanks"]
        NumberKNB <- map["NumberKNB"]
        TotalChiTieu <- map["TotalChiTieu"]
        Id <- map["Id"]
    }
}

class ThongTinCaNhan: Mappable {
    
    var NhomMau = ""
    var CungHoangDao = ""
    var MoTa = ""
    var SoThich = ""
    var TrangMXH = ""
    var TinhCach = ""
    var KyNang = ""
    var DiaDiemYeuThich = ""
    var MonAnYeuThich = ""
    var ThanTuong = ""
    var NhacYeuThich = ""
    var MonTheThaoYeuThich = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        NhomMau <- map["NhomMau"]
        CungHoangDao <- map["CungHoangDao"]
        MoTa <- map["MoTa"]
        SoThich <- map["SoThich"]
        TrangMXH <- map["TrangMXH"]
        TinhCach <- map["TinhCach"]
        KyNang <- map["KyNang"]
        DiaDiemYeuThich <- map["DiaDiemYeuThich"]
        MonAnYeuThich <- map["MonAnYeuThich"]
        ThanTuong <- map["ThanTuong"]
        NhacYeuThich <- map["NhacYeuThich"]
        MonTheThaoYeuThich <- map["MonTheThaoYeuThich"]
        
    }
}
