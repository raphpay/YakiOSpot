//
//  RegistrationView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct RegistrationView: View {
    @Binding var selection: Int
    
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
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                TextField("Email", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
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
            Button(action: {
                selection = 0
            }) {
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
                setUserDefaultsValues(userUID: userUID)
            } onError: { error in
                alertMessage = error
                showAlert.toggle()
            }

        } onError: { error in
            alertMessage = error
            showAlert.toggle()
        }
    }
    
    private func setUserDefaultsValues(userUID: String) {
        UserDefaults.standard.setValue(email, forKey: DefaultKeys.CONNECTED_USER_MAIL)
        UserDefaults.standard.setValue(pseudo, forKey: DefaultKeys.CONNECTED_USER_PSEUDO)
        UserDefaults.standard.setValue(userUID, forKey: DefaultKeys.CONNECTED_USER_ID)
        UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_CONNECTED)
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(selection: .constant(1))
    }
}
