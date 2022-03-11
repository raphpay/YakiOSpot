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
        removeOutdatedUsers()
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
                API.Token.session.updateFirestorePushTokenIfNeeded()
            } onError: { error in
                // No user connected
                API.User.CURRENT_USER_OBJECT = nil
                print(error)
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
    
    private func removeOutdatedUsers() {
        // Fetch all people
        API.Spot.session.getPeoplePresent { peoplePresent in
            // Check for outdated people
            let outdatedPeople = self.getOutdatedPeople(from: peoplePresent)
            // Remove from session
            self.removeUsersFromSession(people: outdatedPeople)
        } onError: { error in
            print("======= \(#function) error getting people present =====", error)
        }
    }
    
    private func getOutdatedPeople(from array: [User]) -> [User] {
        var outdatedPeople: [User] = []
        for people in array {
            if let date = people.presenceDate,
               let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date),
               newDate < Date.now {
                outdatedPeople.append(people)
            }
        }
        return outdatedPeople
    }
    
    private func removeUsersFromSession(people: [User]) {
        // TODO: Refactor this code. We shouldn't have to fetch the spot before removing people
        API.Spot.session.getSpot { spot in
            for person in people {
                API.Spot.session.toggleUserPresence(from: spot, user: person) {
                    API.User.session.toggleUserPresence(person) { isPresent in
                        print("======= \(#function) success =====", isPresent)
                    } onError: { error in
                        print("======= \(#function) error toggling user presence from UserService=====", error)
                    }
                } onError: { error in
                    print("======= \(#function) error toggling user presence from SpotService =====", error, person)
                }
            }
        } onError: { error in
            print("======= \(#function) error getting spot =====", error)
        }
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
