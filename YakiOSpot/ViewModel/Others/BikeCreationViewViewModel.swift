//
//  BikeCreationViewViewModel.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import Foundation
import UIKit
import SwiftUI

final class BikeCreationViewViewModel: ObservableObject {
    @Published var image: UIImage = UIImage(named: Assets.noBike)!
    @Published var bikeModel: String = ""
    
    @Published var hasModifiedImage = false
    @Published var showSheet = false
    @Published var shouldPresentDialog = false
    @Published var selection: UIImagePickerController.SourceType = .camera
    @Published var showActivityIndicator: Bool = false
    @Published var showAlert = false
    @Published var alertTitle = ""
    
    let imageSize = CGFloat(110)
    
    enum AlertType {
        case success, error
    }
}


// MARK: - Public Methods
extension BikeCreationViewViewModel {
    func sendBike(bike: Bike, onImageChanged: @escaping (_ imageData: Data?) -> Void) {
        showActivityIndicator = true
        guard checkModel(model: bike.model) else {
            showActivityIndicator = false
            return
        }
        if bike.photoURL != nil,
           hasModifiedImage == false {
            // URL exist and user haven't change the image
            pushBike(bike)
        } else {
            // URL don't exist or user has changed the image
            pushBikeWithImage(bike, onImageChanged: onImageChanged)
        }
    }
}

// MARK: - Private Methods
extension BikeCreationViewViewModel {
    private func pushBikeWithImage(_ bike: Bike, onImageChanged: @escaping (_ imageData: Data?) -> Void) {
        if image != UIImage(named: Assets.noBike) {
            StorageService.shared.uploadImage(image) { downloadURL in
                let newBike = Bike(id: UUID().uuidString, model: bike.model, photoURL: downloadURL.absoluteString)
                self.pushBike(newBike)
                self.pushFinish(type: .success)
                let imageData = StorageService.shared.convertImageToData(self.image)
                onImageChanged(imageData)
            } onError: { error in
                print("======= \(#function) =====", error)
                self.pushFinish(type: .error)
            }
        }
    }
    
    private func pushBike(_ bike: Bike) {
        API.Bike.session.pushBike(bike) {
            // Show alert and go back
            self.pushFinish(type: .success)
        } onError: { error in
            print("======= \(#function) =====", error)
            self.pushFinish(type: .error)
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
    
    private func pushFinish(type: BikeCreationViewViewModel.AlertType) {
        withAnimation {
            self.showActivityIndicator = false
            showAlert = true
            
            switch type {
            case .success:
                alertTitle = "Bike sauvegardé !"
            case .error:
                alertTitle = "Erreur lors de la sauvegarde"
            }
        }
    }
}
