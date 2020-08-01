//
//  APIService.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/15/20.
//  Copyright © 2020 Bangooh. All rights reserved.
//

import Alamofire
import ObjectMapper
class APIService {
    
    typealias completionHandler = (_ apiResponse: APIResponse) -> Void

    static func request(_ urlRequest: URLRequestConvertible, handler: @escaping (DataResponse<Any>?) -> Void) {
        Alamofire.request(urlRequest).responseJSON { response in
            handler(response)
        }
    }
    
    static func handlerAPI<T: Mappable>(_ urlRequest: URLRequestConvertible, type: T.Type, completionHandler: @escaping (T?, String?) -> Void) -> () {
        Alamofire.request(urlRequest).responseJSON { response in
            print(response)
            if let value = response.result.value as? [String: Any] {
                if let data = value["data"] as? [String: Any] {
                    let data = Mapper<T>().map(JSON: data)
                    completionHandler(data, nil)
                } else if let data = value["data"] as? String {
                    completionHandler(nil, data)
                } else if let data = value["data"] as? [AnyObject] {
                    let data = Mapper<T>().map(JSONObject: data)
                    completionHandler(data, nil)
                } else if let message = value["Message"] as? String {
                    if message == Constants.TOKEN_EXPIRE_MSG {
                        refreshToken { (isLogged) in
                            if isLogged {
                                handlerAPI(urlRequest, type: type, completionHandler: completionHandler)
                            } else {
                                completionHandler(nil, "Bạn chưa đăng nhập hoặc phiên hết hạn! Vui lòng đăng nhập lại")
                                UIViewController().topController().presentConfirmAlertView(title: "Thông báo", message: "Chức năng này yêu cầu bạn phải đăng nhập để thực hiện, vui lòng đăng nhập trước để thực hiện chức năng này", okTitle: "Đăng nhập/Đăng ký", cancelTitle: "Huỷ") { (isOk) in
                                    if isOk {
                                        openLoginVC()
                                    }
                                }
                            }
                        }
                    } else {
                        completionHandler(nil, message)
                    }
                    
                } else {
                    completionHandler(nil, "Xảy ra lỗi")
                }
            } else {
                completionHandler(nil, "Xảy ra lỗi")
            }
        }
    }
    
    static func handlerAPI<T: Mappable>(_ urlRequest: URLRequestConvertible, type: T.Type, completionHandler: @escaping ([T]?, String?) -> Void) -> () {
        Alamofire.request(urlRequest).responseJSON { response in
            print(response)
            if let value = response.result.value as? [String: Any] {
                if let data = value["data"] as? [[String: Any]] {
                    let data = Mapper<T>().mapArray(JSONArray: data)
                    completionHandler(data, nil)
                } else if let data = value["data"] as? String {
                    completionHandler(nil, data)
                } else if let message = value["Message"] as? String {
                    if message == Constants.TOKEN_EXPIRE_MSG {
                        refreshToken { (isLogged) in
                            if isLogged {
                                handlerAPI(urlRequest, type: type, completionHandler: completionHandler)
                            } else {
                                completionHandler(nil, "Bạn chưa đăng nhập hoặc phiên hết hạn! Vui lòng đăng nhập lại")
                                UIViewController().topController().presentConfirmAlertView(title: "Lỗi", message: "Chức năng này yêu cầu bạn phải đăng nhập để thực hiện, vui lòng đăng nhập trước để thực hiện chức năng này", okTitle: "Đăng nhập/Đăng ký", cancelTitle: "Huỷ") { (isOk) in
                                    if isOk {
                                        openLoginVC()
                                    }
                                }
                            }
                        }
                    } else {
                        completionHandler(nil, message)
                    }
                    
                } else {
                    completionHandler(nil, "Xảy ra lỗi")
                }
            } else {
                completionHandler(nil, "Xảy ra lỗi")
            }
        }
    }
    
    static func uploadImage(_ urlRequest: BaseRouter, handler: @escaping (Bool, String?) -> Void) {
        guard let imageData = urlRequest.imageData else { return }
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in urlRequest.parameters ?? [String: Any]() {
                multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
            }
            let fileName = "image.png"
            multipartFormData.append(imageData, withName: "Files", fileName: fileName, mimeType: "image/png")
        }, usingThreshold: UInt64.init(), to: urlRequest.path, method: .post, headers: urlRequest.header)
        { (result) in
            print(result)
            switch result {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let responDict = response.result.value as? [String: Any],
                        let status = responDict["success"] as? Bool, status {
                        if let message = responDict["data"] as? String {
                            handler(true, message)
                        } else {
                            handler(true, nil)
                        }
                    } else {
                        handler(false, nil)
                    }
                }
                
            case .failure(let encodingError):
                handler(false, encodingError.localizedDescription)
                print("Error: \(encodingError.localizedDescription)")
            }
        }
    }
}
