//
//  SearchView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.searchResults, id: \.self) { spot in
                    NavigationLink(destination: SpotView(spot: spot)) {
                        VStack {
                            Text(spot.name)
                            Label("\(spot.tracks) Pistes", systemImage: "bicycle")
                                .foregroundColor(.black)
                                .padding(.top, 5)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchedName)
            .navigationTitle("Rechercher")
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            viewModel.fetchSpots()
        }
    }
    
    
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
