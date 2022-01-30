//
//  BikeCreationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI

struct BikeCreationView: View {
    
    @StateObject private var viewModel = BikeCreationViewViewModel()
    private let imageSize = CGFloat(110)
    
    var body: some View {
        VStack(spacing: 16) {
            Image(uiImage: viewModel.image)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                viewModel.shouldPresentDialog = true
            } label: {
                Text("Ajouter une photo")
                    .font(.system(size: 17))
            }
            
            FormTextField(placeholder: "Modèle du vélo", text: $viewModel.bikeModel) {
                viewModel.pushBike()
            }

            
            Button {
                viewModel.pushBike()
            } label: {
                RoundedButton(title: "Ajouter mon vélo")
            }

            
            Spacer()
        }
        .navigationTitle("Mon bike")
        .confirmationDialog("Choisir une photo", isPresented: $viewModel.shouldPresentDialog) {
            Button("Camera") {
                self.viewModel.selection = .camera
                self.viewModel.showSheet = true
            }
            Button("Bibliothèque") {
                self.viewModel.selection = .photoLibrary
                self.viewModel.showSheet = true
            }
            Button("Annuler", role: .cancel) {}
        }
        .sheet(isPresented: $viewModel.showSheet) {
            ImagePicker(sourceType: viewModel.selection, selectedImage: $viewModel.image)
        }
    }
}

struct BikeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCreationView()
    }
}
