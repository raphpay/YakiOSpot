//
//  StartingView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct StartingView: View {
    @EnvironmentObject var appState: AppState
    @State var selection = 0
    
    var body: some View {
        VStack {
            Spacer(minLength: 50)
            Text("Yaki O Spot")
                .font(.largeTitle)
            Picker("What is your favorite color?", selection: $selection) {
                            Text("Connexion").tag(0)
                            Text("Inscription").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
            Spacer(minLength: 100)
            ZStack {
                if selection == 0 {
                    ConnexionView(selection: $selection, appState: appState)
                } else if selection == 1 {
                    RegistrationView(selection: $selection, appState: appState)
                }
            }
        }
    }
}
