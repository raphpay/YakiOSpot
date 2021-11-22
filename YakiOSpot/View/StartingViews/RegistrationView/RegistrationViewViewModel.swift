//
//  RegistrationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation
import SwiftUI

final class RegistrationViewViewModel: ObservableObject {
    @StateObject private var userSettings = UserSettings()
    @Published var pseudo: String = ""
    @Published var email: String = ""
    @Published var isShowingTabBar = false
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var isUserConnected: Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.IS_USER_CONNECTED)
    }
    
    func didTapRegister(onSuccess: @escaping ((_ user: User) -> Void)) {
        API.Auth.createUser(email: email, password: password) { userUID in
            let user = User(id: userUID, pseudo: self.pseudo, mail: self.email)
            API.User.addUserToDatabase(user) {
                self.pseudo      = ""
                self.email       = ""
                self.password    = ""
                self.isShowingTabBar = true
                onSuccess(user)
            } onError: { error in
                self.alertMessage = error
                self.showAlert.toggle()
            }

        } onError: { error in
            self.alertMessage = error
            self.showAlert.toggle()
        }
    }
}
