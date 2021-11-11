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
            
            Button(action: {}) {
                ButtonView(title: "Inscription", color: .green)
            }
            Text("Vous avez un compte")
            Button(action: {}) {
                Text("Connectez-vous")
            }
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
