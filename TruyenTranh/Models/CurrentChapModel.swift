//
//  CurrentChapModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//

import ObjectMapper

class CurrentChapModel: Mappable {
    var currentChap = CurrentChap()
    var nextchap:String? = nil
    var prevchap:String? = nil
    var isthanks:Bool? = false
    var themkn:Bool? = false
    var hasbuy:Bool? = false
    var loadmethod:Bool? = false
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        currentChap <- map["currentchap"]
        nextchap <- map["nextchap"]
        prevchap <- map["prevchap"]
        isthanks <- map["isthanks"]
        themkn <- map["themkn"]
        hasbuy <- map["hasbuy"]
        loadmethod <- map["loadmethod"]
    }
}
