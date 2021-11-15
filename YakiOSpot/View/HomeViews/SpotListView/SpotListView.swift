//
//  SpotListView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct SpotListView: View {
    @Binding var isConnected: Bool
    
    @StateObject private var viewModel = SpotListViewViewModel()
    
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
                        ForEach(viewModel.mySpots, id: \.self) { spot in
                            NavigationLink(destination: Text("Hello \(spot.name)")) {
                                SpotCellView(spot: spot)
                            }
                        }
                    } header: {
                        Text("Mes spots préférés")
                    }
                    
                    Section {
                        ForEach(viewModel.topSpots, id: \.self) { spot in
                            NavigationLink(destination: Text("Hello \(spot.name)")) {
                                SpotCellView(spot: spot)
                            }
                        }
                    } header: {
                        Text("Top Spots")
                    }
                }
            }
            .navigationTitle("Yaki O Spot")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        viewModel.isShowingSearch = true
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Profile")) {
                        Image(systemName: "person.circle")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Oups"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $viewModel.isShowingSearch, onDismiss: {
            viewModel.isShowingSearch = false
        }) {
            SearchView()
        }
    }
    
    func didTapLogOut() {
        API.Auth.signOut {
            isConnected = false
            removeUserDefaultsValues()
        } onError: { error in
            viewModel.alertMessage = error
            viewModel.showAlert.toggle()
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
