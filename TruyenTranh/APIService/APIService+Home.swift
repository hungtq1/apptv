//
//  APIService+Channel.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import Alamofire
import ObjectMapper
class ChannelRouter: BaseRouter {
    enum Endpoint {
        case getListBoxForum
        case getListTinInbox(String, Int, Int)
        case getDetailTintuc(String)
        case tuLuyen(String)
        case getAdUnitID
    }
    
    var endPoint: Endpoint
    init(endPoint: Endpoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
            case .getListBoxForum:
                return .get
            case .getListTinInbox:
                return .get
            case .getDetailTintuc:
                return .get
            case .tuLuyen:
                return .post
            case .getAdUnitID:
                return .get
        }
    }
    
    override var parameters: [String : Any]? {
        switch endPoint {
            case .getListTinInbox(let boxid, let page, let pagesize):
                return ["boxid":boxid, "page":page, "pagesize":pagesize]
            case .getDetailTintuc(let tinid):
                return ["tinid":tinid]
            case .tuLuyen(let userid):
                return ["UID":userid]
            default:
                return nil
        }
    }
    
    override var path: String {
        switch endPoint {
        case .getListBoxForum:
            return Address.baseUrl + "/api/thanhvien/getlistboxforum"
        case .getListTinInbox:
            return Address.baseUrl + "/api/thanhvien/getlisttininbox"
        case .getDetailTintuc:
            return Address.baseUrl + "/api/thanhvien/getdetailtintuc"
        case .tuLuyen:
            return Address.baseUrl + "/api/thanhvien/tuluyen"
        case .getAdUnitID:
            return Constants.url_tuluyen
        }
    }
}

extension APIService {
    //news
    static func getListBoxForum(_ handler: @escaping ([News]?, String?) -> Void) {
        handlerAPI(ChannelRouter(endPoint: .getListBoxForum), type: News.self) { (response, message) in
            handler(response, message)
        }
    }

    static func getListTinInbox(boxid:String, page:Int, pagesize:Int, _ handler: @escaping (NewsBox?, String?) -> Void) {
        handlerAPI(ChannelRouter(endPoint: .getListTinInbox(boxid, page, pagesize)), type: NewsBox.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func getDetailTintuc(tinid:String, _ handler: @escaping (NewsBoxDetailModel?, String?) -> Void) {
        handlerAPI(ChannelRouter(endPoint: .getDetailTintuc(tinid)), type: NewsBoxDetailModel.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func tuLuyen(uid:String,_ handler: @escaping (Reward?, String?) -> Void) {
        handlerAPI(ChannelRouter(endPoint: .tuLuyen(uid)), type: Reward.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func getAdUnitID(_ handler: @escaping (AdUnit?, String?) -> Void) {
        handlerAPI(ChannelRouter(endPoint: .getAdUnitID), type: AdUnit.self) { (response, message) in
            handler(response, message)
        }
    }
}
