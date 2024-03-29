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
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            if API.User.CURRENT_USER == nil {
                StartingView()
                    .onAppear {
                        UserDefaults.standard.setValue(false, forKey: "_UIConstraintsBasedLayoutLogUnsatisfiable")
                    }
                    .environmentObject(appState)
                    .onAppear {
                        appState.isConnected = false
                    }
            } else {
                HomeTabView()
                    .onAppear {
                        UserDefaults.standard.setValue(false, forKey: "_UIConstraintsBasedLayoutLogUnsatisfiable")
                    }
                    .environmentObject(appState)
                    .onAppear {
                        appState.isConnected = true
                    }
            }
        }
    }
}
