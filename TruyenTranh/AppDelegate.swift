//
//  AppDelegate.swift
//  BangoohTivi
//
//  Created by Trung Hoang Van on 3/14/20.
//  Copyright © 2020 Trung Hoang Van. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
import IQKeyboardManagerSwift
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor(red: 46/255, green: 136/255, blue: 204/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        IQKeyboardManager.shared.enable = true
        // Setup firebase
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        // Setup notification
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        
        NotificationCenter.default.addObserver(self, selector: #selector(screenshotTaken), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SplashVC")
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        return true
    }
    
    @objc func screenshotTaken() {
        
    }
    
    func subscribeTopic(topic: String) {
        print("subscribeTopic: \(topic)")
        Messaging.messaging().subscribe(toTopic: topic) { (error) in
            
        }
    }
    
    func unSubscribeTopic(topic: String) {
        print("unSubscribeTopic: \(topic)")
        Messaging.messaging().unsubscribe(fromTopic: topic, completion: { (error) in
        })
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                print("Firebase registration token: \(fcmToken)")
                UserDefaults.standard.set(fcmToken, forKey: Constants.fcmToken)
                UserDefaults.standard.synchronize()
                let dataDict:[String: String] = ["token": fcmToken]
                NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
            }
        }
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Did receive notification \(remoteMessage.messageID)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("deviceToken: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Did receive notification \(userInfo)")
        if let messageID = userInfo["gcmMessageIDKey"] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        didRecivedNewPush(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
        self.forceLogoutNewPush(notification.request.content.userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        didRecivedNewPush(userInfo)
    }
    
    func didRecivedNewPush(_ userInfo: [AnyHashable: Any]) {
        
    }
    
    func forceLogoutNewPush(_ userInfo: [AnyHashable: Any]) {
        if let dict = userInfo as? [String: Any] {
            if let type = dict["type"] as? String, type == "4" {
                APIService.doLogout { (user, message) in
                    self.window?.rootViewController?.presentSimpleAlertView("Bạn đã đăng xuất trên mọi thiết bị", completion: { (tag) in
                        
                    })
                    Session.shared.listTheoDoi.removeAll()
                    UserDefaults.standard.removeObject(forKey: Constants.TOKEN_KEY)
                    UserDefaults.standard.removeObject(forKey: Constants.USER_ID)
                    UserDefaults.standard.removeObject(forKey: Constants.USERNAME)
                    UserDefaults.standard.removeObject(forKey: Constants.PASSWORD)
                    UserDefaults.standard.synchronize()
                    NotificationCenter.default.post(name: .ReloadHomeView, object: nil)
                    NotificationCenter.default.post(name: .ReloadThanhVien, object: nil)
                }
                print("Thông báo logout")
            }
            print("Data recieved: \(dict)")
        }
    }
}
