//
//  APIService+Login.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/6/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Alamofire
import ObjectMapper
class AuthenRouter: BaseRouter {
    enum Endpoint {
        case doLogin([String: Any])
        case doRegister([String: Any])
        case uploadAvatar(String, String, Data)
        case getDetailUser(String)
        case forgotPassword([String: Any])
        case changePassword([String: Any])
        case doLogout
        case updateProfile([String: Any])
        case updateProfileAdvance([String: Any])
        case getListNotification(Int, Int, String)
        case refreshToken([String: Any])
        case resetDeviceID([String: Any])
    }
    
    var endPoint: Endpoint
    init(endPoint: Endpoint) {
        self.endPoint = endPoint
    }
    
    override var method: HTTPMethod {
        switch endPoint {
        case .getDetailUser:
            return .get
        case .getListNotification:
            return .get
        default:
            return .post
        }
    }
    
    override var parameters: [String : Any]? {
        switch endPoint {
        case .doLogin(let param):
            return param
        case .doRegister(let param):
            return param
        case .forgotPassword(let param):
            return param
        case .changePassword(let param):
            return param
        case .updateProfile(let param):
            return param
        case .updateProfileAdvance(let param):
            return param
        case .refreshToken(let param):
            return param
        case .resetDeviceID(let param):
            return param
        default:
            return nil
        }
    }
    
    override var path: String {
        switch endPoint {
        case .doLogin:
            return Address.baseUrl + "/api/thanhvien/login"
        case .doRegister:
            return Address.baseUrl + "/api/thanhvien/register"
        case .doLogout:
            return Address.baseUrl + "/api/thanhvien/logout"
        case .changePassword:
            return Address.baseUrl + "/api/thanhvien/changepassword"
        case .uploadAvatar:
            return Address.baseUrl + "/api/thanhvien/uploadavatar"
        case .getDetailUser(let userid):
            return Address.baseUrl + "/api/thanhvien/getdetailuser?userid=\(userid)"
        case .forgotPassword:
            return Address.baseUrl + "/api/thanhvien/laylaimatkhau"
        case .updateProfile:
            return Address.baseUrl + "/api/ios/updateinfobasicios"
        case .updateProfileAdvance:
            return Address.baseUrl + "/api/thanhvien/updateinfoadvance"
        case .getListNotification(let ipage, let ipagesize, let userid):
            return Address.baseUrl + "/api/story/getthongbaothanhvien?ipage=\(ipage)&ipagesize=\(ipagesize)&userid=\(userid)"
        case .refreshToken:
            return Address.baseUrl + "/api/thanhvien/refreshtoken"
        case .resetDeviceID:
            return Address.baseUrl + "/api/thanhvien/resetdevice"
        }
    }
    
    override var header: [String : String] {
        let token = UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? ""
        switch endPoint {
        case .uploadAvatar(let client_secret, let client_id, _):
            return ["Authorization":"Bearer " + token,
                    "client-secret":client_secret,
                    "client-id":client_id]
        default:
            return ["Authorization":"Bearer " + token,
            "clientid":"54a0e7371788b51790082b05"]
        }
    }
    
    override var imageData: Data? {
        switch endPoint {
        case .uploadAvatar(_ , _ , let image):
            return image
        default:
            return nil
        }
    }
}

extension APIService {
    static func doLogin(param: [String: Any],_ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .doLogin(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func doRegister(param: [String: Any],_ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .doRegister(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func doLogout(_ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .doLogout), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func forgotPassword(param: [String: Any],_ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .forgotPassword(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func changePassword(param: [String: Any],_ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .changePassword(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func updateUserProfile(param: [String: Any],_ handler: @escaping (UserProfile?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .updateProfile(param)), type: UserProfile.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func uploadAvatar(client_secret: String, client_id: String, image: Data,_ handler: @escaping (Bool, String?) -> Void) {
        uploadImage(AuthenRouter(endPoint: .uploadAvatar(client_secret, client_id, image)), handler: { (isSuccess, message) in
            handler(isSuccess, message)
        })
    }
    
    static func updateProfileAdvance(param: [String: Any],_ handler: @escaping (UserProfile?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .updateProfileAdvance(param)), type: UserProfile.self) { (userProfile, message) in
            handler(userProfile, message)
        }
    }
    
    static func getDetailUser(userid: String,_ handler: @escaping (UserProfile?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .getDetailUser(userid)), type: UserProfile.self) { (userProfile, message) in
            handler(userProfile, message)
        }
    }
    
    static func getListNotification(ipage: Int, ipagesize: Int, userid: String,_ handler: @escaping ([NotificationModel]?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .getListNotification(ipage, ipagesize, userid)), type: NotificationModel.self) { (listNoti, message) in
            handler(listNoti, message)
        }
    }
    
    static func refeshTokenLogin(param: [String: Any], _ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .refreshToken(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
    
    static func resetDeviceID(param: [String: Any], _ handler: @escaping (UserLogin?, String?) -> Void) {
        handlerAPI(AuthenRouter(endPoint: .resetDeviceID(param)), type: UserLogin.self) { (response, message) in
            handler(response, message)
        }
    }
}
