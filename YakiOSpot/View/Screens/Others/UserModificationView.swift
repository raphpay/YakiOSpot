//
//  UserModificationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/02/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserModificationView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var profileState: ProfileState
    @StateObject private var viewModel = UserModificationViewViewModel()
    
    @State private var alertType: AlertType = .image
    
    enum AlertType {
        case dialog, image, membership, password, logout
    }
    
    private let imageSize = CGFloat(135)
    
    var isMember: Bool {
        guard let bool = profileState.user.isMember else { return false }
        return bool
    }
    
    var body: some View {
        ScrollView {
            
            profileImage
            
            FormTextField(isSecured: false, placeholder: "Pseudo", text: $profileState.user.pseudo, submitLabel: .next) {
                viewModel.saveUser(profileState.user.pseudo)
            }
            
            actionsForm
        }
        .onTapGesture {
            hideKeyboard()
        }
        .navigationTitle("Modifier")
        .confirmationDialog("Choisir une photo", isPresented: $viewModel.shouldPresentDialog) { alertItem }
        .sheet(isPresented: $viewModel.showSheet) {
            ImagePicker(sourceType: viewModel.selection, selectedImage: $viewModel.image, hasModifiedImage: $viewModel.hasModifiedImage, showPicker: $viewModel.showSheet)
        }
    }
    
    var profileImage: some View {
        VStack {
            VStack {
                if let photoURL = profileState.user.photoURL,
                   viewModel.hasModifiedImage == false {
                    WebImage(url: URL(string: photoURL))
                        .resizable()
                        .placeholder(Image(Assets.imagePlaceholder))
                        .frame(width: imageSize, height: imageSize)
                        .aspectRatio(contentMode: .fill)
                        .mask(Circle())
                } else {
                    Image(uiImage: viewModel.image)
                        .resizable()
                        .frame(width: imageSize, height: imageSize)
                        .aspectRatio(contentMode: .fill)
                        .mask(Circle())
                }
            }
            .overlay(BadgeIcon(user: $profileState.user), alignment: .topTrailing)
            
            VStack(alignment: .center, spacing: 10) {
                Button {
                    viewModel.shouldPresentDialog = true
                    alertType = .image
                } label: {
                    Text("Modifier la photo de profil")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                
                Button {
                    viewModel.saveUser(profileState.user.pseudo)
                } label: {
                    Text("Sauvegarder")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
        }
    }    

    var actionsForm: some View {
        VStack(alignment: .leading) {
            Button {
                viewModel.shouldPresentDialog = true
                alertType = .membership
            } label: {
                Text(isMember ? "Je suis déjà adhérent !" : "Je certifie être adhérent")
                    .font(.system(size: 16))
                    .foregroundColor(isMember ? .gray : .blue)
            }.disabled(isMember)
            Divider()
            
            Button {
                viewModel.shouldPresentDialog = true
                alertType = .password
            } label: {
                Text("Mot de passe oublié")
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
            }
            Divider()
            
            Button {
                viewModel.shouldPresentDialog = true
                alertType = .logout
            } label: {
                Text("Déconnexion")
                    .font(.system(size: 16))
                    .foregroundColor(.red)
            }
        }
        .frame(width: 333)
        .padding()
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous).foregroundColor(.ui.gray).opacity(0.2))
    }
    
    var alertItem: some View {
        VStack {
            switch alertType {
            case .dialog:
                Button("OK") { dismiss() }
            case .image:
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
            case .membership:
                Button("Oui !") {
                    viewModel.certifyMembership { isMember, memberType in
                        profileState.updateMembership(isMember: isMember, memberType: memberType)
                    }
                }
                Button("Non pas encore 🤭", role: .cancel) { }
            case .password:
                Button("Envoyer un mail") { }
                Button("Annuler", role: .cancel) { }
            case .logout:
                Button("Oui !", role: .destructive) {
                    viewModel.certifyMembership { isMember, memberType in
                        profileState.updateMembership(isMember: isMember, memberType: memberType)
                    }
                }
                Button("Pas maintenant", role: .cancel) { }
            }
        }
    }
}
