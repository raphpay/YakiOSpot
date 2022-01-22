//
//  ConnexionView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

enum ConnexionFormTextField {
    case mail, password
}

struct ConnexionView: View {
    @Binding var selection: Int
    @ObservedObject var appState: AppState
    @StateObject var viewModel = ConnexionViewViewModel()
    @FocusState private var focus: ConnexionFormTextField?
    
    var body: some View {
        VStack {
            VStack {
                FormTextField(placeholder: "Adresse email", text: $viewModel.email) {
                    focus = .password
                }.focused($focus, equals: .mail)
                FormTextField(isSecured: true, placeholder: "Mot de passe", text: $viewModel.password, submitLabel: .done) {
                    startConnexionProcess()
                }.focused($focus, equals: .password)
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.didTapForgotPassword()
                    }) {
                        Text("Mot de passe oublié ?")
                            .font(.system(size: 14))
                    }
                    .padding(.trailing)
                }
            }
            
            Spacer()

            Button(action: {
                startConnexionProcess()
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
        .fullScreenCover(isPresented: $viewModel.isShowingTabBar) {
            HomeTabView()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oups"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    private func startConnexionProcess() {
        viewModel.didTapConnect {
            appState.isConnected = true
        }
    }
}

struct ConnexionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnexionView(selection: .constant(0), appState: AppState())
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
