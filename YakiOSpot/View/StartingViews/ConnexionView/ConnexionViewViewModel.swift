//
//  ConnexionViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 14/11/2021.
//

import Foundation

final class ConnexionViewViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isShowingTabBar: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var isValidForm: Bool {
        guard !email.isEmpty, !password.isEmpty else {
            return false
        }
        return true
    }
    
    var isUserConnected: Bool {
        if UserDefaults.standard.value(forKey: DefaultKeys.IS_USER_CONNECTED) as? Bool == true {
            return true
        } else {
            return false
        }
    }
    
    func didTapConnect() {
        API.Auth.signIn(email: email, password: password) { userID in
            API.User.getUserPseudo(with: userID) { pseudo in
                self.setUserDefaultsValues(pseudo: pseudo, userID: userID)
                self.email = ""
                self.password = ""
                self.isShowingTabBar.toggle()
            } onError: { error in
                self.alertMessage = error
                self.showAlert.toggle()
            }
        } onError: { error in
            self.alertMessage = error
            self.showAlert.toggle()
        }
    }
    
    func setUserDefaultsValues(pseudo: String, userID: String) {
        UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_CONNECTED)
        UserDefaults.standard.set(pseudo, forKey: DefaultKeys.CONNECTED_USER_PSEUDO)
        UserDefaults.standard.set(email, forKey: DefaultKeys.CONNECTED_USER_MAIL)
        UserDefaults.standard.set(userID, forKey: DefaultKeys.CONNECTED_USER_ID)
    }
}
