//
//  YakiOSpotApp.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI
import Firebase

@main
struct YakiOSpotApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if API.User.CURRENT_USER != nil {
                HomeTabView()
                    .onAppear {
                        print("appear HomeTabView")
                    }
            } else {
                StartingView()
                    .onAppear {
                        print("appear StartingView")
                    }
            }
        }
    }
}
