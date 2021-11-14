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
    @State var mySpots: [Spot] =  []
    @State var topSpots: [Spot] = []
    
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
                            NavigationLink(destination: Text("Hello \(spot.name)")) {
                                SpotView(spot: spot)
                            }
                        }
                    } header: {
                        Text("Mes spots préférés")
                    }
                    
                    Section {
                        ForEach(topSpots, id: \.self) { spot in
                            SpotView(spot: spot)
                        }
                    } header: {
                        Text("Top Spots")
                    }
                }
            }
            .navigationTitle("Yaki O Spot")
        }
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
        SpotListView(isConnected: .constant(true), mySpots: Spot.mockMySpots, topSpots: Spot.mockTopSpots)
    }
}
