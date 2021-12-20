//
//  AppDelegate.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 18/12/2021.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
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
        
        return true
    }
}
