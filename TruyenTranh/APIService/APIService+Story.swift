//
//  APIService+Story.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import Alamofire
import ObjectMapper

class StoryRouter: BaseRouter {
    enum Endpoint {
        case getTruyenTheoDoi(Int, Int, String)
        case postTruyenTheodoi([String: Any])
        case getListDanDuoc
        case getLichRaTruyen(Int)
        case muaPhapBao([String: Any])
        case getListPhapBaoUser(String)
        case suDungPhapBao([String: Any])
        case timKiemTruyen([String: Any])
    }
    
    var endPoint: Endpoint
    init(endPoint: Endpoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
        case .getTruyenTheoDoi:
            return .get
        case .getListDanDuoc:
            return .get
        case .getLichRaTruyen:
            return .get
        case .getListPhapBaoUser:
            return .get
        default:
            return .post
        }
    }
    
    override var parameters: [String : Any]? {
        switch endPoint {
        case .muaPhapBao(let param):
            return param
        case .suDungPhapBao(let param):
            return param
        case .timKiemTruyen(let param):
            return param
        default:
            return nil
        }
    }
    
    override var path: String {
        switch endPoint {
        case .getTruyenTheoDoi(let ipage, let ipagesize, let userid):
            return Address.baseUrl + "/api/story/gettruyentheodoi?ipage=\(ipage)&ipagesize=\(ipagesize)&userid=\(userid)"
        case .postTruyenTheodoi:
            return Address.baseUrl + "/api/story/posttheodoitruyen"
        case .getListDanDuoc:
            return Address.baseUrl + "/api/thanhvien/getlistdanduoc"
        case .getLichRaTruyen(let days):
            return Address.baseUrl + "/api/thanhvien/getLichRaTruyen?iDay=\(days)"
        case .muaPhapBao:
            return Address.baseUrl + "/api/thanhvien/muaphapbao"
        case .getListPhapBaoUser(let userid):
            return Address.baseUrl + "/api/thanhvien/getlistphapbaouser?TVID=\(userid)"
        case .suDungPhapBao:
            return Address.baseUrl + "/api/thanhvien/sudungphapbao"
        case .timKiemTruyen:
            return Address.baseUrl + "/api/story/timkiemtruyen"
        }
    }
}

extension APIService {
    static func getTruyenTheoDoi(ipage: Int, ipagesize: Int, userid: String, _ handler: @escaping ([StoryTheoDoi]?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .getTruyenTheoDoi(ipage, ipagesize, userid)), type: DataStoryTheoDoi.self) { (response, message) in
            handler(response?.theodoi, message)
        }
    }
    
    static func postTheoDoiTruyen(param: [String: Any], _ handler: @escaping (Truyen?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .postTruyenTheodoi(param)), type: Truyen.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func getListDanDuoc(_ handler: @escaping ([DanDuoc]?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .getListDanDuoc), type: DanDuoc.self) { (listDanDuoc, message) in
            handler(listDanDuoc, message)
        }
    }
    
    static func getLichRaTruyen(iDay: Int,_ handler: @escaping ([LichRaTruyen]?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .getLichRaTruyen(iDay)), type: LichRaTruyen.self) { (lichRaTruyen, message) in
            handler(lichRaTruyen, message)
        }
    }
    
    static func muaPhapBao(param: [String: Any],_ handler: @escaping(DanDuoc?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .muaPhapBao(param)), type: DanDuoc.self) { (danDuoc, message) in
            handler(danDuoc, message)
        }
    }
    
    static func getListPhapBaoUser(userid: String,_ handler: @escaping (PhapBaoUser?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .getListPhapBaoUser(userid)), type: PhapBaoUser.self) { (listDanDuoc, message) in
            handler(listDanDuoc, message)
        }
    }
    
    static func suDungPhapBaoUser(param: [String: Any],_ handler: @escaping (DanDuoc?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .suDungPhapBao(param)), type: DanDuoc.self) { (listDanDuoc, message) in
            handler(listDanDuoc, message)
        }
    }
    
    static func timKiemTruyen(param: [String: Any],_ handler: @escaping (StorySearch?, String?) -> Void) {
        handlerAPI(StoryRouter(endPoint: .timKiemTruyen(param)), type: StorySearch.self) { (storySearch, message) in
            handler(storySearch, message)
        }
    }
}
