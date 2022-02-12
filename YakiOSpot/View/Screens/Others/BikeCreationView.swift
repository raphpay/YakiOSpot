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
            content
            if viewModel.animateActivityIndicator {
                spinnerView
            }
        }
        .navigationTitle("Mon bike")
        .confirmationDialog("Choisir une photo", isPresented: $viewModel.shouldPresentDialog) {
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
        .sheet(isPresented: $viewModel.showSheet) {
            ImagePicker(sourceType: viewModel.selection, selectedImage: $viewModel.image, hasModifiedImage: $viewModel.hasModifiedImage, showPicker: $viewModel.showSheet)
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 16) {
            if let bikeURL =  profileState.bike.photoURL,
               viewModel.hasModifiedImage == false {
                WebImage(url: URL(string: bikeURL))
                    .resizable()
                    .placeholder(Image(Assets.noBike))
                    .frame(width: viewModel.imageSize, height: viewModel.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .frame(width: viewModel.imageSize, height: viewModel.imageSize)
                    .background(Color.black.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            Button {
                viewModel.shouldPresentDialog = true
            } label: {
                Text("Ajouter une photo")
                    .font(.system(size: 17))
            }
            
            FormTextField(placeholder: "Modèle du vélo", text: $profileState.bike.model) {
                viewModel.sendBike(bike: profileState.bike)
            }
            
            Button {
                viewModel.sendBike(bike: profileState.bike)
            } label: {
                RoundedButton(title: "Ajouter mon vélo")
            }

            Spacer()
        }
    }
    
    var spinnerView: some View {
        ZStack {
            Color.black.opacity(0.75)
                .edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.white)
                .frame(width: 200, height: 200)
            
            VStack {
                ActivityIndicator(shouldAnimate: $viewModel.animateActivityIndicator)
                LoadingText()
            }
        }
    }
}
