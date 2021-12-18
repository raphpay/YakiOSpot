//
//  UserSettings.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import Foundation
import SwiftUI

final class UserSettings: ObservableObject {
    @AppStorage(DefaultKeys.CONNECTED_USER) private var userData: Data?
    
    @Published var currentUser = User()
    @Published var isConnected = false
    
    func saveUser(_ user: User) {
        do {
            currentUser = user
            isConnected = true
            
            let data = try JSONEncoder().encode(currentUser)
            UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_CONNECTED)
            
            userData = data
        } catch let error {
            print(error)
        }
    }
    
    func removeLoggedInUser() {
        do {
            isConnected = false
            let currentUser = User()
            
            let data = try JSONEncoder().encode(currentUser)
            UserDefaults.standard.set(false, forKey: DefaultKeys.IS_USER_CONNECTED)
            
            userData = data
        } catch let error {
            print(error)
        }
    }
    
    
    func retrieveUser() {
        guard let userData = userData else {
            return
        }

        do {
            currentUser = try JSONDecoder().decode(User.self, from: userData)
        } catch let error {
            print("Error decoding current user", error)
        }
    }
}
