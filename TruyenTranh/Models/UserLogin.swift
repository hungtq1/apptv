//
//  UserProfile.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/3/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import ObjectMapper

class UserLogin: Mappable {
    var token = ""
    var refreshTK = ""
    var user = User()
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        token <- map["token"]
        refreshTK <- map["refreshTK"]
        var userLog: User? = nil
        user <- map["user"]
        userLog <- map["userlog"]
        if let userLog = userLog {
            user = userLog
        }
    }
}

class User: Mappable {
    
    var Email = ""
    var ID = ""
    var UserName = ""
    var Avatar = ""
    var Active = 0
    var UserType = 0
    var DanhHieu = ""
    var KinhNghiem = 0
    var Dangcap = DangCap()
    var CongHien = 0
    var DateVip:Date? = nil
    var IsVipMember = false
    var Wallpaper = ""
    var NumberKNB = 0
    var NhomDich = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        Email <- map["Email"]
        ID <- map["ID"]
        UserName <- map["UserName"]
        Avatar <- map["Avatar"]
        Active <- map["Active"]
        UserType <- map["UserType"]
        DanhHieu <- map["DanhHieu"]
        KinhNghiem <- map["KinhNghiem"]
        Dangcap <- map["DangCap"]
        CongHien <- map["CongHien"]
        DateVip <- (map["DateVip"],DateFormatterTransform(dateFormatter:dateFormatter))
        IsVipMember <- map["IsVipMember"]
        Wallpaper <- map["Wallpaper"]
        NumberKNB <- map["NumberKNB"]
        NhomDich <- map["NhomDich"]
    }
}

class DangCap: Mappable {
    var SoThuTu = 0
    var DangCapName = ""
    var CongHienYeuCau = 0
    var TriKinhNghiem = 0
    var Id = ""
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        SoThuTu <- map["SoThuTu"]
        DangCapName <- map["DangCapName"]
        CongHienYeuCau <- map["CongHienYeuCau"]
        TriKinhNghiem <- map["TriKinhNghiem"]
        Id <- map["Id"]
    }
}
