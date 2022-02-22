//
//  UserModificationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 16/02/2022.
//

import Foundation
import UIKit
import SwiftUI

final class UserModificationViewViewModel: ObservableObject {
    // MARK: - Properties
    @Published var showSheet = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var hasModifiedImage = false
    @Published var image: UIImage = UIImage(named: Assets.imagePlaceholder)!
    @Published var showDialog = false
    @Published var dialogTitle = ""
    @Published var alertType: AlertType = .pushSuccess
    @Published var showSpinner = false
    @Published var showAlert = false
    @Published var alertTitle = ""
    
    enum AlertType {
        case pushSuccess, pushError, membership, password, logout, emailSent, customError
        
        var title: String {
            switch self {
            case .pushSuccess:
                return "Sauvegarde réussie"
            case .pushError:
                return "Erreur lors de la sauvegarde"
            case .membership:
                return "Tu es adhérent ?"
            case .password:
                return "Envoi d'un nouveau mot de passe"
            case .logout:
                return "Tu veux te déconnecter ?"
            case .emailSent:
                return "Vérifie ton adresse mail !"
            default:
                return ""
            }
        }
    }
}

// MARK: - Actions
extension UserModificationViewViewModel {
    func saveUser(_ pseudo: String) {
        showSpinner = true
        if hasModifiedImage {
            modifyImageAndPseudo(pseudo)
        } else {
            modifyPseudo(pseudo: pseudo)
        }
    }
    
    func certifyMembership(onSuccess: @escaping ((_ isMember: Bool, _ memberType: User.MemberType) -> Void)) {
        // Update user status
        guard var currentNewUser = API.User.CURRENT_USER_OBJECT else { return }
        currentNewUser.isMember = true
        if currentNewUser.memberType == nil {
            currentNewUser.memberType = .rider
        }
        // Send to firebase
        API.User.session.updateCurrentUser(currentNewUser) {
            print("======= \(#function) success =====")
            onSuccess(currentNewUser.isMember!, currentNewUser.memberType!)
        } onError: { error in
            print("======= \(#function) =====", error)
        }
    }
    
    func toggleAlert(type: UserModificationViewViewModel.AlertType? = nil, errorMessage: String? = nil) {
        withAnimation {
            if let type = type {
                self.showAlert = true
                self.alertType = type
                if type == .customError,
                   let error = errorMessage {
                    self.alertTitle = error
                } else {
                    self.alertTitle = type.title
                }
            } else {
                self.showAlert = false
            }
        }
    }
    
    func sendEmail(to email: String) {
        API.Auth.session.sendResetPasswordMail(to: email) {
            self.toggleAlert(type: .emailSent)
        } onError: { error in
            self.toggleAlert(type: .customError, errorMessage: error)
        }

    }
}

// MARK: - Private Methods
extension UserModificationViewViewModel {
    private func modifyImageAndPseudo(_ pseudo: String) {
        if image != UIImage(named: Assets.imagePlaceholder)! {
            StorageService.shared.uploadImage(image, for: .user) { downloadURL in
                guard var newCurrentUser = API.User.CURRENT_USER_OBJECT else { return }
                newCurrentUser.photoURL = downloadURL.absoluteString
                API.User.session.updateCurrentUser(newCurrentUser) {
                    self.modifyPseudo(pseudo: pseudo)
                    print("======= \(#function) success =====", newCurrentUser)
                } onError: { error in
                    self.pushFinish(result: .pushError)
                    print("======= \(#function) =====", error)
                }
            } onError: { error in
                self.pushFinish(result: .pushError)
                print("======= \(#function) =====", error)
            }
        } else {
            showSpinner = false
        }
    }
    
    private func modifyPseudo(pseudo: String) {
        if pseudo != API.User.CURRENT_USER_OBJECT?.pseudo {
            guard var newUser = API.User.CURRENT_USER_OBJECT else { return }
            newUser.pseudo = pseudo
            API.User.session.updateCurrentUser(newUser) {
                self.pushFinish(result: .pushSuccess)
            } onError: { error in
                self.pushFinish(result: .pushError)
            }
        } else {
            showSpinner = false
        }
    }
    
    private func pushFinish(result: UserModificationViewViewModel.AlertType) {
        showSpinner = false
        self.toggleAlert(type: result)
    }
}
