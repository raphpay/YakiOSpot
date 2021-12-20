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
    @ObservedObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if API.User.CURRENT_USER != nil {
                HomeTabView(appState: appState)
                    .onAppear {
                        print("appear HomeTabView")
                    }
            } else {
                StartingView(appState: appState)
                    .onAppear {
                        print("appear StartingView")
                    }
            }
        }
    }
}
