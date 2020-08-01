//
//  APIService+Transaction.swift
//  TruyenTranh
//
//  Created by Trung Hoang Van on 5/7/20.
//  Copyright © 2020 Truyen. All rights reserved.
//

import Alamofire
import ObjectMapper

class TransactionRouter: BaseRouter {
    enum Endpoint {
        case getListTransaction([String: Any])
        case listChapterBuyedByUser([String: Any])
        case napTheDienThoai([String: Any])
        case sendPaymentInAppPurchase([String: Any])
    }
    
    var endPoint: Endpoint
    init(endPoint: Endpoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
        default:
            return .post
        }
    }
    
    override var parameters: [String : Any]? {
        switch endPoint {
        case .getListTransaction(let param):
            return param
        case .listChapterBuyedByUser(let param):
            return param
        case .napTheDienThoai(let param):
            return param
        case .sendPaymentInAppPurchase(let param):
            return param
        default:
            return nil
        }
    }
    
    override var path: String {
        switch endPoint {
        case .getListTransaction:
            return Address.baseUrl + "/api/newstory/GetListGiaoDich"
        case .listChapterBuyedByUser:
            return Address.baseUrl + "/api/newstory/ListChapterBuyedByUser"
        case .napTheDienThoai:
            return Address.baseUrl + "/api/newstory/NapTheDienThoai"
        case .sendPaymentInAppPurchase:
            return Address.baseUrl + "/api/thanhvien/callbackcongnap"
        }
    }
}

extension APIService {
    static func getHistoryTransaction(param: [String: Any], _ handler: @escaping (HistoryLinhThachData?, String?) -> Void) {
        handlerAPI(TransactionRouter(endPoint: .getListTransaction(param)), type: HistoryLinhThachData.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func listChapterBuyedByUser(param: [String: Any], _ handler: @escaping (ChapterBuyData?, String?) -> Void) {
        handlerAPI(TransactionRouter(endPoint: .listChapterBuyedByUser(param)), type: ChapterBuyData.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func napTheDienThoai(param: [String: Any],_ handler: @escaping(NapTheMobi?, String?) -> Void) {
        handlerAPI(TransactionRouter(endPoint: .napTheDienThoai(param)), type: NapTheMobi.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func sendPaymentInAppPurchase(param: [String: Any],_ handler: @escaping(NapTheMobi?, String?) -> Void) {
        handlerAPI(TransactionRouter(endPoint: .sendPaymentInAppPurchase(param)), type: NapTheMobi.self) { (response, message) in
            handler(response, message)
        }
    }
}

