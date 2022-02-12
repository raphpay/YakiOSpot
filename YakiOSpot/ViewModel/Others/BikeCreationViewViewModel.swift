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
    
    @Published var hasModifiedImage = false
    @Published var showSheet = false
    @Published var shouldPresentDialog = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var animateActivityIndicator: Bool = false
    @Published var showAlert = false
    @Published var alertTitle = ""
    
    let imageSize = CGFloat(110)
}


// MARK: - Public Methods
extension BikeCreationViewViewModel {
    func sendBike(bike: Bike) {
        animateActivityIndicator = true
        guard checkModel(model: bike.model) else {
            animateActivityIndicator = false
            return
        }
        if bike.photoURL != nil,
           hasModifiedImage == false {
            // URL exist and user haven't change the image
            pushBike(bike)
        } else {
            // URL don't exist or user has changed the image
            pushBikeWithImage(bike)
        }
    }
}

// MARK: - Private Methods
extension BikeCreationViewViewModel {
    private func pushBikeWithImage(_ bike: Bike) {
        if image != UIImage(named: Assets.noBike) {
            StorageService.shared.uploadImage(image) { downloadURL in
                let bike = Bike(id: UUID().uuidString, model: self.bikeModel, photoURL: downloadURL.absoluteString)
                self.pushBike(bike)
                self.pushFinish(title: "Bike sauvegardé")
            } onError: { error in
                print("======= \(#function) =====", error)
                self.pushFinish(title: "Erreur : Bike non sauvegardé !")
            }

        }
    }
    
    private func pushBike(_ bike: Bike) {
        API.Bike.session.pushBike(bike) {
            // Show alert and go back
            self.pushFinish(title: "Bike sauvegardé !")
        } onError: { error in
            print("======= \(#function) =====", error)
            self.pushFinish(title: "Erreur : Bike non sauvegardé !")
        }
    }
    
    private func checkModel(model: String) -> Bool {
        print("======= \(#function) =====", model)
        if model == "" {
            // Show alert
            return false
        }
        return true
    }
    
    private func pushFinish(title: String) {
        self.animateActivityIndicator = false
        showAlert = true
        alertTitle = title
    }
}
