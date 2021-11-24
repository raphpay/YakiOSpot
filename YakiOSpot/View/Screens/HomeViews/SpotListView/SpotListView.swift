//
//  SpotListView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 11/11/2021.
//

import SwiftUI

struct SpotListView: View {
    @Binding var isConnected: Bool
    @StateObject private var userSettings   = UserSettings()
    @StateObject private var viewModel      = SpotListViewViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    if viewModel.mySpots.isEmpty {
                        Text("Pas de spots préférés")
                        Button {
                            print("Tap no spots")
                        } label: {
                            Text("Créer un spot ?")
                        }
                    } else {
                        ForEach(viewModel.mySpots, id: \.self) { spot in
                            SpotCellView(spot: spot)
                        }
                    }
                } header: {
                    Text("Mes spots préférés")
                }
                
                Section {
                    ForEach(viewModel.topSpots, id: \.self) { spot in
                        NavigationLink(destination: SpotView(spot: spot)) {
                            SpotCellView(spot: spot)
                        }
                    }
                } header: {
                    Text("Top Spots")
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
                    NavigationLink(destination: ProfileView(isConnected: $isConnected)) {
                        Image(systemName: "person.circle")
                            .foregroundColor(.black)
                    }
                }
            }
        }
        .onAppear {
            fetchMySpots()
            fetchTopSpots()
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
    
    func fetchMySpots() {
        API.User.session.getUsersFavoritedSpots { spots in
            print(spots)
        } onError: { error in
            print(error)
        }
        
    }
    
    func fetchTopSpots() {
        
    }
}

struct SpotListView_Previews: PreviewProvider {
    static var previews: some View {
        SpotListView(isConnected: .constant(true))
    }
}
