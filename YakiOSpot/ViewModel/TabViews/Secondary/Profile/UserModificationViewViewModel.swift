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
}

// MARK: - Actions
extension UserModificationViewViewModel {
    func saveUser() {
        if hasModifiedImage {
            sendUserImage()
        }
    }
}

// MARK: - Private Methods
extension UserModificationViewViewModel {
    func sendUserImage() {
        if image != UIImage(named: Assets.imagePlaceholder)! {
            StorageService.shared.uploadImage(image, for: .user) { downloadURL in
                guard var newCurrentUser = API.User.CURRENT_USER_OBJECT else { return }
                newCurrentUser.photoURL = downloadURL.absoluteString
                API.User.session.updateCurrentUser(newCurrentUser) {
                    // Show alert
                    print("======= \(#function) success =====", newCurrentUser)
                } onError: { error in
                    print("======= \(#function) =====", error)
                }
            } onError: { error in
                print("======= \(#function) =====", error)
            }

        }
    }
}
