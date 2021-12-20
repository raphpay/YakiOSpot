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
    
    func didTapConnect(onSuccess: @escaping (() -> Void)) {
        API.Auth.session.signIn(email: email, password: password) { userID in
            API.User.session.getUserPseudo(with: userID) { pseudo in
                self.isShowingTabBar = true
                self.email = ""
                self.password = ""
                onSuccess()
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
