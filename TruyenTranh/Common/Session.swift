//
//  Session.swift
//  MicroInvestment
//
//  Created by Trung Hoang Van on 12/25/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Foundation

class Session {
    static var shared = Session()
    var userLogin = UserLogin()
    var userProfile = UserProfile()
    var listTheoDoi = [StoryTheoDoi]()
    var truyenVuaXem = [StoryModel]() {
        didSet {
            UserDefaults.standard.set(self.truyenVuaXem.toJSONString(), forKey: Constants.TRUYEN_VUA_XEM)
            UserDefaults.standard.synchronize()
        }
    }
}
