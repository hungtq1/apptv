//
//  CommentModel.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 hung. All rights reserved.
//
import ObjectMapper

class CommentModel: Mappable {
    var comment = [Comment]()
    var child_comment = [Comment]()
    var imageuser:String? = nil
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        comment <- map["comments"]
        child_comment <- map["child_comment"]
        imageuser <- map["imageuser"]
    }
}
