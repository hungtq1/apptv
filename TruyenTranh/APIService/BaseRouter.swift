//
//  BaseRouter.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/5/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Alamofire

class BaseRouter: URLRequestConvertible {

    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return ""
    }
    
    var parameters: [String: Any]? {
        return [String: Any]()
    }
    
    var imageData: Data? {
        return nil
    }
    
    var header: [String: String] {
        let token = UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) ?? ""
        return ["Authorization":"Bearer " + token,
                "Device-Id":"",
                "App-Version":"V1.0"]
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = URL(string:path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        urlRequest.timeoutInterval = 30
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        if method == .get {
//            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
//        } else {
//            urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
//        }
        print("==========================================")
        print("Parameters: \(parameters)")
        print("URL: \(String(describing: urlRequest.url!.absoluteString))")
        print("==========================================")
        
        return urlRequest
    }
}
