//
//  RegistrationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct RegistrationView: View {
    @State var pseudo: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isConnected: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    
    var body: some View {
        VStack {
            VStack {
                TextField("Pseudo", text: $pseudo)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                TextField("Email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                SecureField("Mot de passe", text: $password)
                    .frame(height: 55)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
            }
            
            Spacer()
            
            
            Button(action: {
                didTapRegister()
            }) {
                ButtonView(title: "Inscription", color: .green)
            }
            Text("Vous avez un compte ?")
                .padding(.top)
            Button(action: {}) {
                Text("Connectez-vous")
            }
        }
        .fullScreenCover(isPresented: $isConnected) {
            SpotListView(isConnected: $isConnected)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oups"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func didTapRegister() {
        API.Auth.createUser(email: email, password: password) { userUID in
            let user = User(id: userUID, pseudo: pseudo, mail: email)
            API.User.addUserToDatabase(user) {
                pseudo      = ""
                email       = ""
                password    = ""
                isConnected.toggle()
            } onError: { error in
                alertMessage = error
                showAlert.toggle()
            }

        } onError: { error in
            alertMessage = error
            showAlert.toggle()
        }

    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
