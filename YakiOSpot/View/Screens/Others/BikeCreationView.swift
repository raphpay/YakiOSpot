//
//  BikeCreationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct BikeCreationView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = BikeCreationViewViewModel()
    @ObservedObject var profileState: ProfileState
    
    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                bikeImage
                FormTextField(placeholder: "Modèle du vélo", text: $profileState.bike.model) {
                    viewModel.sendBike(bike: profileState.bike) { imageData in
                        if let imageData = imageData {
                            self.profileState.bikeImageData = imageData
                        }
                    }
                }
                Button {
                    viewModel.sendBike(bike: profileState.bike) { imageData in
                        if let imageData = imageData {
                            self.profileState.bikeImageData = imageData
                        }
                    }
                } label: {
                    RoundedButton(title: "Sauvegarder")
                }

                Spacer()
            }
            
            if viewModel.showActivityIndicator {
                Spinner()
            }
            
            if viewModel.showAlert {
                AlertView(alertTitle: viewModel.alertTitle, showAlert: $viewModel.showAlert) {
                    Divider()
                    Button("OK", role: .cancel) { dismiss() }
                    Divider()
                }
            }
        }
        .navigationTitle("Mon bike")
        .confirmationDialog("Choisir une photo", isPresented: $viewModel.shouldPresentDialog) { dialogItem }
        .sheet(isPresented: $viewModel.showSheet) {
            ImagePicker(sourceType: viewModel.selection, selectedImage: $viewModel.image, hasModifiedImage: $viewModel.hasModifiedImage, showPicker: $viewModel.showSheet)
        }
    }
    
    var bikeImage: some View {
        VStack(spacing: 16) {
            if let bikeURL =  profileState.bike.photoURL,
               viewModel.hasModifiedImage == false {
                WebImage(url: URL(string: bikeURL))
                    .resizable()
                    .placeholder(Image(Assets.noBike))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: viewModel.imageSize, height: viewModel.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: viewModel.imageSize, height: viewModel.imageSize)
                    .background(Color.black.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Button {
                viewModel.shouldPresentDialog = true
            } label: {
                Text("Modifier la photo")
                    .font(.system(size: 17))
            }
        }
    }
    
    var dialogItem: some View {
        VStack {
            Button("Camera") {
                self.viewModel.selection = .camera
                self.viewModel.showSheet = true
                self.viewModel.hasModifiedImage = true
            }
            Button("Bibliothèque") {
                self.viewModel.selection = .photoLibrary
                self.viewModel.showSheet = true
                self.viewModel.hasModifiedImage = true
            }
            Button("Annuler", role: .cancel) {}
        }
    }
}
