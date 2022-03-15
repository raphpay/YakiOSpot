//
//  RegistrationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

enum RegistrationFormTextField {
    case pseudo, email, password
}

struct RegistrationView: View {
    @Binding var selection: Int
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = RegistrationViewViewModel()
    @FocusState private var focus: RegistrationFormTextField?
    
    var body: some View {
        VStack {
            VStack {
                FormTextField(placeholder: "Pseudo", text: $viewModel.pseudo) {
                    focus = .email
                }.focused($focus, equals: .pseudo)
                FormTextField(placeholder: "Email", text: $viewModel.email) {
                    focus = .password
                }.focused($focus, equals: .email)
                FormTextField(isSecured: true, placeholder: "Password", text: $viewModel.password) {
                    startRegistrationProcess()
                }.focused($focus, equals: .password)
            }
            
            Spacer()
            
            
            Button(action: {
                startRegistrationProcess()
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
        .onTapGesture {
            hideKeyboard()
        }
        .fullScreenCover(isPresented: $viewModel.isShowingTabBar) {
            HomeTabView()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oups"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func startRegistrationProcess() {
        viewModel.didTapRegister {
            appState.isConnected = true
            selection = 0
        }
    }
}
