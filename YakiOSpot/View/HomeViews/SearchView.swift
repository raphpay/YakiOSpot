//
//  SearchView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @State var spots: [Spot] = []
    @State private var searchedName = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(searchResults, id: \.self) { spot in
                    NavigationLink(destination: Text(spot.name)) {
                        Text(spot.name)
                    }
                }
            }
            .searchable(text: $searchedName)
            .navigationTitle("Rechercher")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            fetchSpots()
        }
    }
    
    var searchResults: [Spot] {
        if searchedName.isEmpty {
            return spots
        } else {
            return spots.filter { $0.name.contains(searchedName) }
        }
    }
    
    func fetchSpots() {
        // TODO: Search for spots in firebase
        API.Spot.getAllSpots { fetchedSpots in
            self.spots = fetchedSpots
        } onError: { error in
            print(error)
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
