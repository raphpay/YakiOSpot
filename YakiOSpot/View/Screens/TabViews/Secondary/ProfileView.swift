//
//  ProfileView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var profileState = ProfileState()
    // TODO: Put this property in app state
    @Binding var isConnected: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                ProfileRow(user: $profileState.user)

                ProfileSection {
                    HStack {
                        StatusButton(isSelected: $profileState.userIsPresent, title: "🚵‍♂️ Au spot", color: .green) {
                            profileState.didTapHereButton()
                        }
                        Spacer()
                        StatusButton(isSelected: $profileState.userIsNotPresent, title: "🚶‍♂️ Plus au spot", color: .red) {
                            profileState.didTapLeavingButton()
                        }
                    }
                    .padding(.horizontal)
                }

                ProfileSection(title: "Mes sessions") {
                    SessionRow(sessions: $profileState.sessions)
                } action: {
                    profileState.showSessionCreation = true
                }
                NavigationLink(destination: PublishSessionView(), isActive: $profileState.showSessionCreation) { }

                ProfileSection(title: "Mon bike") {
                    BikeRow(showBikeCreation: $profileState.showBikeCreation)
                        .padding(.horizontal)
                } action: {
                    profileState.showBikeCreation = true
                }
                NavigationLink(destination: BikeCreationView(),
                               isActive: $profileState.showBikeCreation) { }
            }
        }
        .environmentObject(profileState)
        .navigationTitle("Profil")
        .alert(profileState.alertTitle, isPresented: $profileState.showAlert) {
            Button(profileState.agreeButtonText) {
                profileState.toggleUserPresence()
            }
            Button(profileState.cancelButtonText) {}
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
