//
//  ConnexionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct ConnexionView: View {
    @State var identifier: String = ""
    @State var password: String = ""
    @State var isConnected: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Pseudo ou adresse mail", text: $identifier)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                SecureField("Mot de passe", text: $password)
                    .frame(height: 55)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Text("Mot de passe oublié ?")
                            .font(.system(size: 14))
                    }
                    .padding(.trailing)
                }
            }
            
            Spacer()

            Button(action: {
                
            }) {
                ButtonView(title: "Connexion")
            }
            Text("Pas encore de compte ?")
                .padding(.top)
            Button(action: {}) {
                Text("Inscrivez-vous")
            }
        }
        .fullScreenCover(isPresented: $isConnected) {
            SpotListView(isConnected: $isConnected)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oups"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func didTapConnect() {
        API.Auth.signIn(email: identifier, password: password) { userID in
            identifier = ""
            password = ""
            isConnected.toggle()
        } onError: { error in
            alertMessage = error
            showAlert.toggle()
        }

    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView()
    }
}

struct ButtonView: View {
    var title: String
    var color: Color = Color.blue
    
    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .frame(width: 200, height: 50)
            .background(color)
            .cornerRadius(10)
    }
}
