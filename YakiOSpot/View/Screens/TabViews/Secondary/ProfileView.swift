//
//  ProfileView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewViewModel()
    @Binding var isConnected: Bool
    private let imageSize = CGFloat(85)
    
    var body: some View {
        ScrollView {
            VStack {
                profileRow
                
                ProfileSection {
                    HStack {
                        StatusButton(isSelected: $viewModel.userIsPresent, title: "🚵‍♂️ Au spot", color: .green) {
                            viewModel.didTapHereButton()
                        }
                        Spacer()
                        StatusButton(isSelected: $viewModel.userIsNotPresent, title: "🚶‍♂️ Plus au spot", color: .red) {
                            viewModel.didTapLeavingButton()
                        }
                    }
                    .padding(.horizontal)
                }
                
                ProfileSection(title: "Mes sessions") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            SessionCard()
                            SessionCard()
                            SessionCard()
                        }
                        .padding(.horizontal)
                    }
                } action: {
                    print("Hello world")
                }
                
                
                ProfileSection(title: "Mon bike") {
                    BikeCard()
                        .padding(.horizontal)
                }
            }
        }
            .navigationTitle("Profil")
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert) {
                Button(viewModel.agreeButtonText) {
                    viewModel.toggleUserPresence()
                }
                Button(viewModel.cancelButtonText) {}
            }
    }
    
    var profileRow: some View {
        HStack(alignment: .center, spacing: 28) {
            Image(Assets.imagePlaceholder)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .aspectRatio(contentMode: .fill)
                .mask(Circle())
//                .overlay(BadgeIcon(), alignment: .topTrailing)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.user.pseudo)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Rider")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()

            NavigationLink(destination: Text("Hello World")) {
                Image(systemName: "highlighter")
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
            }

        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    func didTapLogOut() {
        API.Auth.session.signOut {
            isConnected = false
        } onError: { error in
            isConnected = true
        }
    }
}
