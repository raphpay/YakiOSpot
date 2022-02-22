//
//  AppState.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 20/12/2021.
//

import Foundation

final class AppState: ObservableObject {
    @Published var showButton: Bool = false
    @Published var isConnected: Bool = false
}


// MARK: - Actions
extension AppState {
    func logOut() {
        API.Auth.session.signOut {
            self.isConnected = false
            print("======= \(#function) user sign out successfully =====")
        } onError: { error in
            print("======= \(#function) =====", error)
        }

    }
}
