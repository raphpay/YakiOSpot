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
    @State private var showSessionCreation: Bool = false
    @State private var showBikeCreation: Bool = false
    @State private var animateActivityIndicator: Bool = true
    
    var body: some View {
        ZStack {
            profileView
            
            if animateActivityIndicator {
                spinnerView
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
    
    var profileView : some View {
        ScrollView {
            VStack {
                ProfileRow(user: $viewModel.user)

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
                    SessionRow(sessions: $viewModel.sessions)
                } action: {
                    showSessionCreation = true
                }
                NavigationLink(destination: PublishSessionView(), isActive: $showSessionCreation) { }


                ProfileSection(title: "Mon bike") {
                    BikeRow()
                        .padding(.horizontal)
                } action: {
                    showBikeCreation = true
                }
                NavigationLink(destination: BikeCreationView(), isActive: $showBikeCreation) { }
            }
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
                ActivityIndicator(shouldAnimate: $animateActivityIndicator)
                LoadingText()
            }
        }
    }
    
    func didTapLogOut() {
        API.Auth.session.signOut {
            isConnected = false
        } onError: { error in
            isConnected = true
        }
    }
}
