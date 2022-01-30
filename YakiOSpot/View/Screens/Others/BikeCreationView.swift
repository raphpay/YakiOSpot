//
//  BikeCreationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI

struct BikeCreationView: View {
    
    @State private var image: UIImage = UIImage(named: Assets.noBike)!
    @State private var bikeModel: String = ""
    @State private var showSheet = false
    @State private var shouldPresentDialog = false
    @State private var selection: UIImagePickerController.SourceType = .camera
    private let imageSize = CGFloat(110)
    
    var body: some View {
        VStack(spacing: 16) {
            Image(uiImage: image)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Button {
                shouldPresentDialog = true
            } label: {
                Text("Ajouter une photo")
                    .font(.system(size: 17))
            }
            
            FormTextField(placeholder: "Modèle du vélo", text: $bikeModel) {
                pushBike()
            }

            
            Button {
                pushBike()
            } label: {
                RoundedButton(title: "Ajouter mon vélo")
            }

            
            Spacer()
        }
        .navigationTitle("Mon bike")
        .confirmationDialog("Choisir une photo", isPresented: $shouldPresentDialog) {
            Button("Camera") {
                selection = .camera
                showSheet = true
            }
            Button("Bibliothèque") {
                selection = .photoLibrary
                showSheet = true
            }
            Button("Annuler", role: .cancel) {}
        }
        .sheet(isPresented: $showSheet) {
            ImagePicker(sourceType: selection, selectedImage: self.$image)
        }
    }
    
    func pushBike() {
        guard bikeModel != "" else { return }
        if image != UIImage(named: Assets.noBike) {
            guard let currentUser = API.User.CURRENT_USER_OBJECT else { return }
            StorageService.shared.uploadImage(image, for: currentUser.id) { downloadURL in
                let bike = Bike(id: UUID().uuidString, model: bikeModel, photoURL: downloadURL.absoluteString)
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

struct BikeCreationView_Previews: PreviewProvider {
    static var previews: some View {
        BikeCreationView()
    }
}
