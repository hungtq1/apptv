//
//  NotificationModel.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/16/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import ObjectMapper

class NotificationModel: Mappable {
    var UserID = ""
    var UserName = ""
    var DateCreate = ""
    var ContentNotifyCation = ""
    var IsRead = 0
    var Id = ""

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        UserID <- map["UserID"]
        UserName <- map["UserName"]
        DateCreate <- map["DateCreate"]
        ContentNotifyCation <- map["ContentNotifyCation"]
        IsRead <- map["IsRead"]
        Id <- map["Id"]
    }
}
