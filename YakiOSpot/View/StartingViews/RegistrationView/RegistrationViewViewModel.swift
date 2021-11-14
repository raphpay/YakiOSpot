//
//  RegistrationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation

final class RegistrationViewViewModel: ObservableObject {
    @Published var pseudo: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isConnected: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    func didTapRegister() {
        API.Auth.createUser(email: email, password: password) { userUID in
            let user = User(id: userUID, pseudo: self.pseudo, mail: self.email)
            API.User.addUserToDatabase(user) {
                self.pseudo      = ""
                self.email       = ""
                self.password    = ""
                self.isConnected.toggle()
                self.setUserDefaultsValues(userUID: userUID)
            } onError: { error in
                self.alertMessage = error
                self.showAlert.toggle()
            }

        } onError: { error in
            self.alertMessage = error
            self.showAlert.toggle()
        }
    }
    
    private func setUserDefaultsValues(userUID: String) {
        UserDefaults.standard.setValue(email, forKey: DefaultKeys.CONNECTED_USER_MAIL)
        UserDefaults.standard.setValue(pseudo, forKey: DefaultKeys.CONNECTED_USER_PSEUDO)
        UserDefaults.standard.setValue(userUID, forKey: DefaultKeys.CONNECTED_USER_ID)
        UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_CONNECTED)
    }
}
