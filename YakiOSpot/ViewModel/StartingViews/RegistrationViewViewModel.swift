//
//  RegistrationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation
import SwiftUI

final class RegistrationViewViewModel: ObservableObject {
    @Published var pseudo: String = ""
    @Published var email: String = ""
    @Published var isShowingTabBar = false
    @Published var password: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var isUserConnected: Bool {
        return UserDefaults.standard.bool(forKey: DefaultKeys.IS_USER_CONNECTED)
    }
    
    func didTapRegister(onSuccess: @escaping (() -> Void)) {
        API.Auth.session.createUser(email: email, password: password) { userUID in
            let user = User(id: userUID, pseudo: self.pseudo, mail: self.email)
            API.User.session.addUserToDatabase(user) {
                API.User.session.updateLocalCurrentUser(id: userUID) {
                    self.resetFields()
                    self.isShowingTabBar = true
                    API.Token.session.updateFirestorePushTokenIfNeeded()
                    onSuccess()
                } onError: { error in
                    self.showErrorAlert(error: error)
                }
            } onError: { error in
                self.showErrorAlert(error: error)
            }
        } onError: { error in
            self.showErrorAlert(error: error)
        }
    }
    
    private func resetFields() {
        self.pseudo      = ""
        self.email       = ""
        self.password    = ""
    }
    
    private func showErrorAlert(error: String) {
        self.alertMessage = error
        self.showAlert.toggle()
    }
}
