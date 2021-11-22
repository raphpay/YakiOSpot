//
//  ProfileView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isConnected: Bool
    @StateObject var userSettings = UserSettings()
    @State var displayName: String = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(displayName)!")
            Button {
                didTapLogOut {
                    userSettings.removeLoggedInUser()
                }
            } label: {
                Text("Se déconnecter")
            }
        }
        .onAppear {
            userSettings.retrieveUser()
            displayName = userSettings.currentUser.pseudo
            print("isConnected :", UserDefaults.standard.bool(forKey: DefaultKeys.IS_USER_CONNECTED))
        }
    }
    
    func didTapLogOut(onSuccess: @escaping (() -> Void)) {
        API.Auth.signOut {
            isConnected = false
            onSuccess()
        } onError: { error in
//            viewModel.alertMessage = error
//            viewModel.showAlert.toggle()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(isConnected: .constant(true), displayName: "World")
    }
}
