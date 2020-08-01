//
//  APIResponse.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/5/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Alamofire
import ObjectMapper

struct APIResponse {
    
    var statusCode: Int = -1
    var responseMessage: String = ""
    var data: Any?
    var accessToken: String = ""
    var errors = [Int]()
    var errorServer: Error?
    var result: Any?
    var status = ""
    
    init(_ response: DataResponse<Any>) {
        self.statusCode = response.response?.statusCode ?? -1
        self.errorServer = response.error
        if let dict = response.result.value as? [String: Any] {
            self.responseMessage = dict["message"] as! String
            self.data = dict["data"]
        } else if let message = response.error?.localizedDescription {
            self.responseMessage = message
        }
    }
    
    func isSuccess() -> Bool {
        if statusCode == APIStatus.API_CODE_OK || statusCode == APIStatus.API_CODE_OK_200 {
            return true
        }
        return false
    }
    
    func message() -> String {
        if statusCode == APIStatus.API_CODE_FAIL {
            if responseMessage.count > 0 {
                return responseMessage
            }
            
            return "Có lỗi xẩy ra. Vui lòng thử lại"
        }
        return responseMessage
    }
}
