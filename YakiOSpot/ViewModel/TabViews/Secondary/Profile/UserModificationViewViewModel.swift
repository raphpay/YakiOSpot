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
}

// MARK: - Actions
extension UserModificationViewViewModel {
    func saveUser() {
        if hasModifiedImage {
            sendUserImage()
        }
        // Verify the change of the name
    }
}

// MARK: - Private Methods
extension UserModificationViewViewModel {
    private func sendUserImage() {
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
    
    private func pushFinish(title: String) {
        alertTitle = title
        showAlert.toggle()
    }
}
