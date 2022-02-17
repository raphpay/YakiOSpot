//
//  UserModificationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 16/02/2022.
//

import Foundation
import UIKit

final class UserModificationViewViewModel: ObservableObject {
    // MARK: - Properties
    @Published var showSheet = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var hasModifiedImage = false
    @Published var image: UIImage = UIImage(named: Assets.imagePlaceholder)!
    @Published var shouldPresentDialog = false
    @Published var alertTitle = ""
    @Published var showAlert = false
    @Published var showMembershipAlert = false
}

// MARK: - Actions
extension UserModificationViewViewModel {
    func saveUser(_ pseudo: String) {
        if hasModifiedImage {
            modifyImage()
            modifyPseudo(pseudo: pseudo)
        } else {
            modifyPseudo(pseudo: pseudo, shouldShowAlert: true)
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
}

// MARK: - Private Methods
extension UserModificationViewViewModel {
    private func modifyImage() {
        if image != UIImage(named: Assets.imagePlaceholder)! {
            StorageService.shared.uploadImage(image, for: .user) { downloadURL in
                guard var newCurrentUser = API.User.CURRENT_USER_OBJECT else { return }
                newCurrentUser.photoURL = downloadURL.absoluteString
                API.User.session.updateCurrentUser(newCurrentUser) {
                    self.pushFinish(title: "Sauvegarde réussie")
                    print("======= \(#function) success =====", newCurrentUser)
                } onError: { error in
                    self.pushFinish(title: "Erreur lors de la sauvegarde")
                    print("======= \(#function) =====", error)
                }
            } onError: { error in
                self.pushFinish(title: "Erreur lors de la sauvegarde")
                print("======= \(#function) =====", error)
            }
        }
    }
    
    private func modifyPseudo(pseudo: String, shouldShowAlert: Bool = false) {
        if pseudo != API.User.CURRENT_USER_OBJECT?.pseudo {
            guard var newUser = API.User.CURRENT_USER_OBJECT else { return }
            newUser.pseudo = pseudo
            API.User.session.updateCurrentUser(newUser) {
                if shouldShowAlert {
                    self.pushFinish(title: "Sauvegarde réussie")
                }
            } onError: { error in
                self.pushFinish(title: "Erreur lors de la sauvegarde")
            }
        }
    }
    
    private func pushFinish(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}
