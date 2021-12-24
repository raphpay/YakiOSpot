//
//  AppDelegate.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 18/12/2021.
//

import UIKit
import Firebase
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        configureFirebase()
        configureNotificationCenter(application: application)
        configureFirebaseMessaging()
        return true
    }
}

// MARK: - Private Methods
extension AppDelegate {
    private func configureFirebase() {
        FirebaseApp.configure()
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        
        if let firUser = API.User.CURRENT_USER {
            // A user is connected
            API.User.session.getUserFromUID(firUser.uid) { user in
                API.User.CURRENT_USER_OBJECT = user
                UserDefaults.standard.set(user.pseudo, forKey: "pseudo")
            }
        } else {
            // No user connected
            API.User.CURRENT_USER_OBJECT = nil
        }
    }
    
    private func configureNotificationCenter(application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        let authorizationOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authorizationOptions) { granted, error in
            print("user has granted notifications", granted)
            print("Error is", error ?? "")
        }
        
        application.registerForRemoteNotifications()
    }
    
    private func configureFirebaseMessaging() {
        Messaging.messaging().delegate = self
    }
}

// MARK: - UNUserNotificationCenterDelegate
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Register
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Fail to register
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError", error)
    }
    
    // Will present notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // TODO: Process notification here
        print("===== willPresent notification =====", notification)
        completionHandler([.badge, .sound])
    }
    
    // Did receive notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // TODO: Process notification here
        print("didReceive response", response)
        print("didReceive response.notification", response.notification)
        completionHandler()
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let tokenDict = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"),
                                        object: nil,
                                        userInfo: tokenDict)
    }
}
