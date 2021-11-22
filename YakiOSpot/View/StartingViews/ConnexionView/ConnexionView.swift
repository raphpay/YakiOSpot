//
//  ConnexionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct ConnexionView: View {
    @Binding var selection: Int
    @StateObject var userSettings = UserSettings()
    @StateObject var viewModel = ConnexionViewViewModel()
    
    var body: some View {
        VStack {
            VStack {
                TextField("Pseudo", text: $viewModel.email)
                                .textFieldStyle(.roundedBorder)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .autocapitalization(.none)
                                .disableAutocorrection(true)
                SecureField("Mot de passe", text: $viewModel.password)
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
                viewModel.didTapConnect { user in
                    userSettings.saveUser(user)
                }

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
            if viewModel.isUserConnected {
                viewModel.isShowingTabBar = true
            } else {
                viewModel.isShowingTabBar = false
            }
        })
        .fullScreenCover(isPresented: $viewModel.isShowingTabBar) {
            SpotListView(isConnected: $viewModel.isShowingTabBar)
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oups"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
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
