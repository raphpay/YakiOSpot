//
//  RegistrationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct RegistrationView: View {
    @Binding var selection: Int
    @StateObject private var userSettings   = UserSettings()
    @StateObject private var viewModel      = RegistrationViewViewModel()
    
    var body: some View {
        VStack {
            VStack {
                TextField("Pseudo", text: $viewModel.pseudo)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                TextField("Email", text: $viewModel.email)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                SecureField("Mot de passe", text: $viewModel.password)
                    .frame(height: 55)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            
            Button(action: {
                viewModel.didTapRegister { user in
                    userSettings.saveUser(user)
                }
            }) {
                ButtonView(title: "Inscription", color: .green)
            }
            
            Text("Vous avez un compte ?")
                .padding(.top)
            
            Button(action: {
                selection = 0
            }) {
                Text("Connectez-vous")
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowingTabBar) {
            SpotListView(isConnected: $viewModel.isShowingTabBar)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oups"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(selection: .constant(1))
    }
}
