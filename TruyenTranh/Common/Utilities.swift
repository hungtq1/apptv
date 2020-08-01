//
//  Utilities.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/5/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Foundation
import UIKit

public func downloadFileFrom(url: URL, to localUrl: URL, completion: @escaping (Bool) -> ()) {
    let sessionConfig = URLSessionConfiguration.default
    let session = URLSession(configuration: sessionConfig)
    let request = try! URLRequest(url: url, method: .get)
    
    let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
        if let tempLocalUrl = tempLocalUrl, error == nil {
            // Success
            if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                print("Success: \(statusCode)")
            }
            
            do {
                try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                completion(true)
            } catch (let writeError) {
                completion(false)
                print("error writing file \(localUrl) : \(writeError)")
            }
            
        } else {
            print("Failure: %@", error?.localizedDescription)
        }
    }
    task.resume()
}

public func refreshToken(completionHandler: @escaping (Bool) -> Void) {
    var uuid = ""
    let keyChain = Keychain(service: Constants.keyChainService)
    do {
        let uuidKeychain = try keyChain.get(Constants.UUID_STR)
        if let uuidStr = uuidKeychain?.fromBase64() {
            uuid = uuidStr
        } else {
            uuid = UUID().uuidString
            keyChain[Constants.UUID_STR] = uuid.toBase64()
        }
    } catch {
        Toast.showErr("Lỗi lưu dữ liệu vào keychain")
    }
    if let oldToken = UserDefaults.standard.string(forKey: Constants.TOKEN_KEY) {
        let strEnc = try! (oldToken + "|" + uuid).aesEncrypt(key: Constants.KEY_ENCRYPT, iv: Constants.IV_ENCRYPT)
        let param = ["data": strEnc.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "+", with: "-")]
        APIService.refeshTokenLogin(param: param) { (userLogin, message) in
            if let userLogin = userLogin {
                UserDefaults.standard.set(userLogin.token, forKey: Constants.TOKEN_KEY)
                UserDefaults.standard.synchronize()
                completionHandler(true)
            } else {
                completionHandler(false)
                Toast.showErr("Có lỗi xảy ra với refresh token")
            }
        }
    } else {
        completionHandler(false)
    }
    
//    if let userName = UserDefaults.standard.string(forKey: Constants.USERNAME), let password = UserDefaults.standard.string(forKey: Constants.PASSWORD) {
//        let strEnc = try! (userName + "|" + password + "|" + "\(Int(Date().timeIntervalSince1970 + 780) )" + "|" + uuid).aesEncrypt(key: Constants.KEY_ENCRYPT, iv: Constants.IV_ENCRYPT)
//        let param = ["enc": strEnc.replacingOccurrences(of: "/", with: "_").replacingOccurrences(of: "+", with: "-")]
//        APIService.doLogin(param: param) { (userProfile, message) in
//            if let userProfile = userProfile {
//                UserDefaults.standard.set(userProfile.token, forKey: Constants.TOKEN_KEY)
//                UserDefaults.standard.synchronize()
//                completionHandler(true)
//            } else {
//                completionHandler(false)
//                Toast.showErr("Có lỗi xảy ra")
//            }
//        }
//    } else {
//        completionHandler(false)
//    }
}

func saveImage(image: UIImage, index:Int, folderName:URL) -> Bool {
    guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
        return false
    }
    do {
        try data.write(to: folderName.appendingPathComponent("p\(index).png"))
        return true
    } catch {
        print(error.localizedDescription)
        return false
    }
}

func getFileFromDocumentsFolder(url:URL) -> String{
    do {
        let directoryContents = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
        let formatHtml = directoryContents.filter{ $0.pathExtension == "html" }
        return formatHtml.first!.lastPathComponent
    } catch {
        print(error)
    }
    return ""
}

func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
    URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
}

func clearTempFolder() {
    let fileManager = FileManager.default
    let tempFolderPath = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
    do {
        let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath!.path)
        for filePath in filePaths {
            try fileManager.removeItem(atPath: tempFolderPath!.path + "/\(filePath)")
        }
    } catch {
        print("Could not clear temp folder: \(error)")
    }
}

func deleteFileInFolder(file:String) {
    let fileManager = FileManager.default
    do {
        try fileManager.removeItem(atPath: file)
    } catch {
        print("Could not clear temp folder: \(error)")
    }
}

func saveLocalChaperRead(storyID:String, chapID:String, chapName:String){
    let plistPath = getPath(storyID: storyID)
    let fileManager = FileManager.default
    if(!fileManager.fileExists(atPath: plistPath)){
        let dictData: NSMutableDictionary = [:]
        //saving values
        dictData.setObject(chapID, forKey: "chapID" as NSCopying)
        dictData.setObject(chapName, forKey: "chapName" as NSCopying)
        let someData = NSMutableArray(object: dictData)
        let isWritten = someData.write(toFile: plistPath, atomically: true)
        print("is the file created: \(isWritten)")
    }else{
        if let retrieveData = NSMutableArray(contentsOfFile: plistPath){
            let dictData: NSMutableDictionary = [:]
            dictData.setObject(chapID, forKey: "chapID" as NSCopying)
            dictData.setObject(chapName, forKey: "chapName" as NSCopying)
            if !retrieveData.contains(dictData){
                retrieveData.add(dictData)
                if retrieveData.count > 4{
                    retrieveData.removeObject(at: 0)
                }
                if retrieveData.write(toFile: plistPath, atomically: true){
                    print("plist_write")
                }else{
                    print("plist_write_error")
                }
            }
        }else{
            print("plist_write")
        }
    }
}

func readLocalChaperRead(storyID:String)->NSMutableArray{
    let plistPath = getPath(storyID: storyID)
    if let myDict = NSMutableArray(contentsOfFile: plistPath){
        return myDict
    }else{
        return []
    }
}

func getPath(storyID:String) -> String {
  let plistFileName = "\(storyID).plist"
  let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
  let documentPath = paths[0] as NSString
  let plistPath = documentPath.appendingPathComponent(plistFileName)
  return plistPath
}

func abbreviateNumber(num: NSNumber) -> NSString {
    var ret: NSString = ""
    let abbrve: [String] = ["K", "M", "B"]

    let floatNum = num.floatValue

    if floatNum > 1000 {

        for i in 0..<abbrve.count {
            let size = pow(10.0, (Float(i) + 1.0) * 3.0)
            if (size <= floatNum) {
                let numVal = floatNum / size
                let str = floatToString(val: numVal)
                ret = NSString(format: "%@%@", str, abbrve[i])
            }
        }
    } else {
        ret = NSString(format: "%d", Int(floatNum))
    }

    return ret
}

func floatToString(val: Float) -> NSString {
    var ret = NSString(format: "%.1f", val)
    var c = ret.character(at: ret.length - 1)

    while c == 48 {
        ret = ret.substring(to: ret.length - 1) as NSString
        c = ret.character(at: ret.length - 1)


        if (c == 46) {
            ret = ret.substring(to: ret.length - 1) as NSString
        }
    }
    return ret
}

func showAlertView(title:String, view:UIViewController){
    let alert = UIAlertController(title: "Thông báo", message: title, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Thoát", style: .default, handler: { action in
        
    }))
    view.present(alert, animated: true, completion: nil)
}

func formatNewsHTML(title:String, content:String) -> String{
    let result = "<!DOCTYPE html PUBLIC -//W3C//DTD HTML 4.01//EN http://www.w3.org/TR/html4/strict.dtd><html><head><meta http-equiv='Content-Type' content='text/html'; charset=utf-8><meta http-equiv='Content-Style-Type' content='text/css'><title></title><link href='https://fonts.googleapis.com/css?family=Roboto' rel='stylesheet'><style type='text/css'>#content-tin{font: 400 1.125rem arial;line-height: 1.5;margin: 0 0 1em 0;color: #222;word-break: break-word;}#content-tin h2{font: normal 2rem 'Roboto';}#content-tin img{margin: 10px auto;max-width: 90%;display: block;}.wrap_tintuc{position: relative;padding-left: 15px;padding-right: 15px;}.wrap_tintuc a{text-decoration: none;color: #222;}.wrap_tintuc h3{font: 700 1.3125rem Roboto,serif;line-height: 1.625;color:#000;font-size:1.3125rem;margin-bottom: 10px;}</style></head><body class='wrap_tintuc'><h3>\(title)</h3><div id='content-tin'>\(content)</div><script>function removeStyle(){var ancestor = document.getElementById('content-tin'),descendents = ancestor.getElementsByTagName('*');var i, e, d;for (i = 0; i < descendents.length; ++i){e = descendents[i];e.removeAttribute('style');e.removeAttribute('class');e.removeAttribute('height');e.removeAttribute('width');}}removeStyle();</script><!-- END  JAVASCRIPT --></body></html>"
    return result
}

public func openLoginVC() {
    let loginVC = LoginViewController.instantiateViewControllerFromStoryboard(storyboardName: .login)
    UIViewController().topController().navigationController?.pushViewController(loginVC, animated: true)
}
