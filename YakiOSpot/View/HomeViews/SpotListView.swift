//
//  SpotListView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct SpotListView: View {
    @Binding var isConnected: Bool
    
    @State var showAlert: Bool = false
    @State var alertMessage: String = ""
    
    // TODO: To be removed
    var mySpots = ["Spot 1", "Spot2"]
    var topSpots = ["Spot 1", "Spot2", "Spot 3"]
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    didTapLogOut()
                } label: {
                    Text("Sign Out")
                        .foregroundColor(.red)
                }
                List {
                    Section {
                        ForEach(mySpots, id: \.self) { spot in
                            Text(spot)
                        }
                    } header: {
                        Text("Mes Spots préférés")
                    }
                    Section {
                        ForEach(topSpots, id: \.self) { spot in
                            Text(spot)
                        }
                    } header: {
                        Text("Top Spots")
                    }
                }
            }
        }
        .onAppear(perform: {
            print("On apopei \(UserDefaults.standard.value(forKey: DefaultKeys.IS_USER_CONNECTED))")
            print("On apopei \(UserDefaults.standard.value(forKey: DefaultKeys.CONNECTED_USER_MAIL))")
            print("On apopei \(UserDefaults.standard.value(forKey: DefaultKeys.CONNECTED_USER_PSEUDO))")
        })
        .navigationTitle("Yaki O Spot")
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Oups"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func didTapLogOut() {
        API.Auth.signOut {
            isConnected = false
            removeUserDefaultsValues()
        } onError: { error in
            alertMessage = error
            showAlert.toggle()
        }
    }
    
    func removeUserDefaultsValues() {
        UserDefaults.standard.setValue(false, forKey: DefaultKeys.IS_USER_CONNECTED)
        UserDefaults.standard.removeObject(forKey: DefaultKeys.CONNECTED_USER_ID)
        UserDefaults.standard.removeObject(forKey: DefaultKeys.CONNECTED_USER_PSEUDO)
        UserDefaults.standard.removeObject(forKey: DefaultKeys.CONNECTED_USER_MAIL)
    }
}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView(isConnected: .constant(true))
    }
}
