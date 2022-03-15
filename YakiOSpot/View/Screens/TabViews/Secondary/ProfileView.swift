//
//  ProfileView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileView: View {
    
    @StateObject private var profileState = ProfileState()
    
    var body: some View {
        ScrollView {
            VStack {
                UserRow(profileState: profileState)

                buttonSection

                sessionSection

                bikeSection
            }
        }
        .navigationTitle("Profil")
        .alert(profileState.alertTitle, isPresented: $profileState.showAlert) {
            Button(profileState.agreeButtonText) {
                profileState.confirmAlert()
            }
            Button(profileState.cancelButtonText) {}
        }
    }
    
    var buttonSection: some View {
        ProfileSection {
            HStack {
                StatusButton(isSelected: $profileState.userIsPresent, title: "🚵‍♂️ Au spot", color: .green) {
                    profileState.didTapHereButton()
                }
                Spacer()
                StatusButton(isSelected: $profileState.userIsPresent.not, title: "🚶‍♂️ Plus au spot", color: .red) {
                    profileState.didTapLeavingButton()
                }
            }
            .padding(.horizontal)
        }
    }
    
    var sessionSection: some View {
        VStack {
            ProfileSection(title: "Mes sessions") {
                SessionRow(sessions: $profileState.sessions)
            } action: {
                profileState.showSessionCreation = true
            }
            NavigationLink(destination: PublishSessionView(), isActive: $profileState.showSessionCreation) { }
        }
    }
    
    var bikeSection: some View {
        VStack {
            ProfileSection(title: "Mon bike") {
                BikeRow(profileState: profileState)
                    .padding(.horizontal)
            } action: {
                profileState.showBikeCreation = true
            }
            NavigationLink(destination: BikeCreationView(profileState: profileState),
                           isActive: $profileState.showBikeCreation) { }
        }
    }
}
