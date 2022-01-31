//
//  BikeCreationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import Foundation
import UIKit

final class BikeCreationViewViewModel: ObservableObject {
    @Published var image: UIImage = UIImage(named: Assets.noBike)!
    @Published var bikeModel: String = ""
    @Published var showSheet = false
    @Published var shouldPresentDialog = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var animateActivityIndicator: Bool = true
    
    func pushBike() {
        guard bikeModel != "" else { return }
        if image != UIImage(named: Assets.noBike) {
            guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
            StorageService.shared.uploadImage(image, for: currentUser.id) { downloadURL in
                let bike = Bike(id: UUID().uuidString, model: self.bikeModel, photoURL: downloadURL.absoluteString)
                API.Bike.session.pushBike(bike) {
                    // Show alert and go back
                } onError: { error in
                    print(error)
                }
            } onError: { error in
                print(error)
            }

        } else {
            let bike = Bike(id: UUID().uuidString, model: bikeModel, photoURL: nil)
            API.Bike.session.pushBike(bike) {
                // Show alert and go back
            } onError: { error in
                print(error)
            }
        }
    }
}
