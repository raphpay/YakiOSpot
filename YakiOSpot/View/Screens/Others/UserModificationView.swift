//
//  UserModificationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 12/02/2022.
//

import SwiftUI

struct UserModificationView: View {
    
    @ObservedObject var profileState: ProfileState
    
    private let imageSize = CGFloat(135)
    
    var body: some View {
        ScrollView {
            Image(Assets.imagePlaceholder)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .aspectRatio(contentMode: .fill)
                .mask(Circle())
            
            VStack(alignment: .center, spacing: 10) {
                Button {
                    //
                } label: {
                    Text("Modifier la photo de profil")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
                
                Button {
                    //
                } label: {
                    Text("Sauvegarder")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }

            
            FormTextField(isSecured: false, placeholder: "Pseudo", text: $profileState.user.pseudo, submitLabel: .next) {
                // On commit action
            }
            
            ActionForm(profileState: profileState)
        }
        .navigationTitle("Modifier")
    }
}

struct ActionForm: View {
    
    @ObservedObject var profileState: ProfileState
    
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                //
            } label: {
                Text("Je certifie être adhérent")
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
            }
            Divider()
            
            Button {
                //
            } label: {
                Text("Mot de passe oublié")
                    .font(.system(size: 16))
                    .foregroundColor(.blue)
            }
            Divider()
            
            Button {
                //
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
}
