//
//  ConnexionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct ConnexionView: View {
    @Binding var selection: Int
    
    @State var email: String = ""
    @State var password: String = ""
    @State var isConnected: Bool = false
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack {
            VStack {
                TextField("Pseudo ou adresse mail", text: $email)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                SecureField("Mot de passe", text: $password)
                    .frame(height: 55)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
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
                didTapConnect()
            }) {
                ButtonView(title: "Connexion")
            }
            Text("Pas encore de compte ?")
                .padding(.top)
            Button(action: {
                selection = 1
            }) {
                Text("Inscrivez-vous")
            }
        }
        .onAppear(perform: {
            if let isUserConnected = UserDefaults.standard.value(forKey: DefaultKeys.IS_USER_CONNECTED) as? Bool {
                isConnected = isUserConnected
                print("onAppear \(isConnected)")
            } else {
                isConnected = false
                print("onAppear else \(isConnected)")
            }
        })
        .fullScreenCover(isPresented: $isConnected) {
            SpotListView(isConnected: $isConnected)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oups"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func didTapConnect() {
        API.Auth.signIn(email: email, password: password) { userID in
            API.User.getUserPseudo(with: userID) { pseudo in
                setUserDefaultsValues(pseudo: pseudo, userID: userID)
                email = ""
                password = ""
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
    
    func setUserDefaultsValues(pseudo: String, userID: String) {
        UserDefaults.standard.set(true, forKey: DefaultKeys.IS_USER_CONNECTED)
        UserDefaults.standard.set(pseudo, forKey: DefaultKeys.CONNECTED_USER_PSEUDO)
        UserDefaults.standard.set(email, forKey: DefaultKeys.CONNECTED_USER_MAIL)
        UserDefaults.standard.set(userID, forKey: DefaultKeys.CONNECTED_USER_ID)
    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView(selection: .constant(0))
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
