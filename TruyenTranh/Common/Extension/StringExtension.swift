//
//  StringExtension.swift
//  MicroInvest
//
//  Created by Trung Hoang Van on 12/5/19.
//  Copyright © 2019 Funtap JSC. All rights reserved.
//

import Foundation
import CryptoSwift
import CommonCrypto

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    /// Check valid email
    ///
    /// - Returns: Bool
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    /// Check valid phonenumber
    ///
    /// - Returns: Bool
    func isValidPhone() -> Bool {
        let phonenumberRegex = "^(09|03|05|07|08)+([0-9]{8})$"
        print("Phone regex: \(phonenumberRegex)")
        let phonenumber = NSPredicate(format:"SELF MATCHES %@", phonenumberRegex)
        return phonenumber.evaluate(with: self)
    }
    
    /// Check valid password
    ///
    /// - Returns: Bool
    func isValidPassword() -> Bool {
        let passwordRegexLength = "^.{6,18}$"
        let password = NSPredicate(format:"SELF MATCHES %@", passwordRegexLength)
        return password.evaluate(with: self)
    }
    
    func isValidCharacter() -> Bool {
        let regex = "^[A-Za-z0-9]{6,32}$"
        let password = NSPredicate(format:"SELF MATCHES %@", regex)
        return password.evaluate(with: self)
    }
    
    func hasSpecialCharacters() -> Bool {
        let regex = ".*[^A-Za-z].*"
        let password = NSPredicate(format:"SELF MATCHES %@", regex)
        return password.evaluate(with: self)
    }
    
    /// Check valid fullname
    ///
    /// - Returns: Bool
    func isValidFullname() -> Bool {
        let fullnameRegexLength = "^.{3,30}$"
        let fullname = NSPredicate(format:"SELF MATCHES %@", fullnameRegexLength)
        return fullname.evaluate(with: self)
    }
    
    /// Check valid card ID
    ///
    /// - Returns: Bool
    func isValidCardID() -> Bool {
        let cardRegexLength = "^.{8,12}$"
        let cardID = NSPredicate(format:"SELF MATCHES %@", cardRegexLength)
        return cardID.evaluate(with: self)
    }
    
    func isImageLink() -> Bool {
        let lower = self.lowercased()
        return (lower.contains(".jpg") || lower.contains(".png") || lower.contains(".jpeg")) && !lower.isEmpty
    }
    
    /// String to Date
    ///
    /// - Returns: Date
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = DateFormat.YYYYMMDD.rawValue
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    
    /// String to Date UTC
    ///
    /// - Parameter dateFormat: String
    /// - Returns: Date
    func toDateUTC(dateFormat:String) -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = DateFormat.YYYYMMDD.rawValue
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
        
    }
    
    /// String to Date
    ///
    /// - Parameter dateFormat: String
    /// - Returns: Date
    func toDate(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = DateFormat.YYYYMMDD.rawValue
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    func toDate2(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    
    func getTime() -> (hour: Int, minute: Int) {
        var hour = 0
        var minute = 0
        if let hourStr = Int(self.prefix(2)) {
            hour = hourStr
        }
        
        if let minuteStr = Int(self.suffix(2)) {
            minute = minuteStr
        }
        return (hour, minute)
    }
    
    func localizationDate(dateFormat: DateFormat, fromLocale: String, toLocale: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: fromLocale)
        dateFormatter.dateFormat = dateFormat.rawValue
        let dateFormatterConvert = DateFormatter()
        dateFormatterConvert.calendar = Calendar(identifier: .iso8601)
        dateFormatterConvert.locale = Locale(identifier: toLocale)
        dateFormatterConvert.dateFormat = dateFormat.rawValue
        return dateFormatterConvert.string(from: dateFormatter.date(from: self)!)
    }
}

enum DateFormat: String {
    case HHmmDDMMYYYY = "HH:mm dd-MM-yyyy"
    case ddMMYYYY = "dd/MM/yyyy"
    case dd_MM_YYYY = "dd-MM-yyyy"
    case yyyyMMdd = "yyyy/MM/dd"
    case YYYYMMDD = "yyyy-MM-dd"
    case HH_mm_DD_MM_YYYY = "HH_mm_dd_MM_yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case HHmm = "HH:mm"
    case hhmma = "hh:mm a"
    case ddhhmma = "dd hh:mm a"
    case hhmmass = "hh:mm:ss a"
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmssSSSz = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
    case yyyyMMddHHmmssSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case yyyyMMddHHmmssSSSSSSZ = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
    case yyyyMMddHHmmssSSS = "yyyy-MM-dd HH:mm:ss.SSS"
    case MMddyyyyHHmm = "MM-dd-yyyy HH:mm"
    case MMMddyyyyHHmm = "MMM-dd-yyyy HH:mm"
    case MMMddyyyyhhmma = "MMM dd yyyy hh:mm a"
    case MMMddyyyyhhmmssa = "MMM dd, yyyy hh:mm:ss a"
    case MMMddyyyy = "MMM dd, yyyy"
    case MMMyyyy = "MMM yyyy"
    case yyyyMMddHHmmssSSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyyMMddTHHmma = "yyyy-MM-dd hh:mm a"
    case ddMMyyyyTHHmmssa = "dd-MM-yyyy hh:mm:ss a"
    case MMM_dd = "MMM-dd"
    case dd = "dd"
    case E = "E"
    case EEEE = "EEEE"
    case MMM = "MMM"
    case EEEEMMMddyyyy = "EEEE, MMM dd, yyyy"
    case EEEEMMMMddyyyy = "EEEE, MMMM dd, yyyy"
    case yyyyMMddhhmm = "yyyy-HH-dd hh:mm"
    case yyyyMMddHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddMMMyyyyhhmma = "dd MMM yyyy hh:mm a"
    case ddMMMyyyy = "dd MMM yyyy"
    case ddMMMMyyyy = "dd MMMM yyyy"
    case ddMMMyyyyhhmmssa = "dd MMM yyyy hh:mm:ss a"
    case ddMMyyyyhhmma = "dd/MM/yy : hh:mm a"
    case MMMMdd = "MMMM dd"
    case MMMMddyyyy = "MMMM dd, yyyy"
    case LLL = "LLL"
    //08:36AM - 31/11/2019
    case hhmmaddMMYYYY = "hh:mm a - dd/MM/YYYY"
}

extension Int {
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))?.replacingOccurrences(of: ".", with: ",") ?? "0"
    }
    
    func currencyFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value:self)) ?? "0"
    }
}

extension Double {
    func numberFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self))?.replacingOccurrences(of: ".", with: ",") ?? "0"
    }
    
    func currencyFormatter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "vi_VN")
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        return numberFormatter.string(from: NSNumber(value:self)) ?? "0"
    }
}

extension String {
    func currentcyToNumber() -> Double {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.numberStyle = .currency
        return formatter.number(from: self)?.doubleValue ?? 0
    }
}

extension String {
    func aesEncrypt(key: String, iv: String) throws -> String {
        let encrypted = try AES(key: key, iv: iv, padding: .pkcs7).encrypt([UInt8](self.data(using: .utf8)!))
        return Data(encrypted).base64EncodedString()
    }

    func aesDecrypt(key: String, iv: String) throws -> String {
        guard let data = Data(base64Encoded: self) else { return "" }
        let decrypted = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8](data))
        return String(bytes: decrypted, encoding: .utf8) ?? self
    }
    
    func MD5() -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    private var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .unicode, allowLossyConversion: false) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.unicode.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func convertHtml() -> NSAttributedString{
        guard let data = data(using: .unicode) else { return NSAttributedString() }
        do{
            return try NSAttributedString(data: data, options: [.documentType:NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.unicode.rawValue], documentAttributes: nil)
        }catch{
            return NSAttributedString()
        }
    }
    
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
