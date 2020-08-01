//
//  Constants.swift
//  TruyenTranh
//
//  Created by hungtq on 5/4/20.
//  Copyright © 2020 Hung. All rights reserved.
//

import Foundation
import UIKit

let screenSizeWidth = UIScreen.main.bounds.width
let screenSizeHeight = UIScreen.main.bounds.height
struct ScreenSize
{
    static let SCREEN_WIDTH = screenSizeWidth
    static let SCREEN_HEIGHT = screenSizeHeight
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
let IS_IPHONE_8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

let IS_IPHONE_XS = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
let IS_IPHONE_11 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 828.0
let IS_IPHONE_PRO = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1125.0
let IS_IPHONE_PRO_MAX = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 1242.0

public class Constants {
    static let APP_NAME = "TruyenSieuHay"
    static let CANCEL_BUTTON = "Cancel"
    static let OK_BUTTON = "OK"
    static let FISRT_OPEN_APP = "FISRT_OPEN_APP"
    static let TOKEN_KEY = "TOKEN_KEY"
    static let PASSWORD = "PASSWORD"
    static let USER_PROFILE = "USER_PROFILE"
    static let TRUYEN_VUA_XEM = "TRUYEN_VUA_XEM"
    static let KEY_ENCRYPT = "336ec2cd10d8313fdd1da9e928c58ba5".md5()
    static let KEY_ENCRYPT_GENERAL = "336ec2cd10d8313fdd1da9e928c58ba5"
    static let IV_ENCRYPT = "gqLOHUioQ0QjhuvI"
    static let USERNAME = "USERNAME"
    static let USER_ID = "USER_ID"
    static let VERSION_NAME = "4.2.0"
    static let VERSION_CODE = 29
    static let TOKEN_EXPIRE_MSG = "Authorization has been denied for this request."
    static let fcmToken = "fcmToken"
    static let MSG_TITLE1 = "Bạn muốn báo lỗi chương này? \nHãy nói cho bọn mình biết chương này bị lỗi gì vào dưới đây nhé? Nếu link die toàn chap, bạn có thể bấm vào nút Đổi SV Ảnh\nNếu đổi SV Ảnh mà vẫn bị lỗi thì báo với bạn mình nhé!"
    static let MSG_TITLE2 = "Bọn mình sẽ kiểm tra chương này theo nguyên nhân bạn report. Nếu chính xác. bạn sẽ được cộng +35 kinh nghiệm. Nếu sai thì bạn sẽ bị ban 3 ngày"
    static let MSG_PURCHASE_CHAP = "Nội dung hình ảnh của chương này bị khoá, bạn có thể xem bản video (nếu có) hay MỞ KHOÁ, hoặc chờ đến khi bản hình ảnh ra, Để mở khoá vui lòng click vào nút Mở khoá ở trên để xem full chap. \nTrân trọng!"
    public static let column: CGFloat = 2
    public static let PAGE_SIZE: Int = 15
    public static let minLineSpacing: CGFloat = 5.0
    public static let minItemSpacing: CGFloat = 5.0
    public static let offset: CGFloat = 5.0 // TODO: for each side, define its offset
    public static let EMO_FILE_FORMAT = "gif"
    public static let PLIST_FILE_FORMAT = "plist"
    public static let CATEGORY_VIP = "5d0667320631ac2f7cf98fc8"
    public static let RGB_COLOR = UIColor(red: 35.0/255.0, green: 117.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    static let baseUrlImage = "https://quantri.truyensieuhay.com/Pictures/Truyen/Large/"
    static let baseHelp = "https://m.truyensieuhay.com/huongdandoctruyen.html"
    static let linkStory = "https://m.truyensieuhay.com/downapp.aspx"
    static let baseURLVideo = "https://www.youtube.com/embed/"
    static let UUID_STR = "UUID_STR"
    static let keyChainService = Bundle.main.bundleIdentifier ?? "truyensieuhay.beblue.com"
    static let url_updateVer = "https://m.truyensieuhay.com/downapp.aspx"
    static let url_tuluyen = "https://quantri.truyensieuhay.com/pictures/ads.json"
}
