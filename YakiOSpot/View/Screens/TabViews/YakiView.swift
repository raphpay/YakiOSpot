//
//  YakiView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 03/01/2022.
//

import SwiftUI

struct YakiView: View {
    
    @ObservedObject var appState: AppState
    @ObservedObject private var viewModel = YakiViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(SampleText.features)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)
                if (viewModel.peoplePresent.isEmpty) {
                    EmptySpotView()
                } else {
                    List {
                        Section {
                            ForEach(viewModel.peoplePresent, id: \.self) { person in
                                Text(person.pseudo)
                                    .font(.system(size: 20))
                            }
                        } header: {
                            Text("Personnes présentes")
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchData()
            }
            .navigationTitle("Yaki O Spot")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        //
                    }) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView(isConnected: $appState.isConnected)) {
                        Image(systemName: "person.circle")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
        }
    }
}

struct EmptySpotView: View {
    var body : some View {
        Spacer()
        Text(SampleText.noPeople)
            .font(.system(size: 16, weight: .bold))
            .multilineTextAlignment(.center)
        Image(Assets.noPeople)
            .resizable()
            .frame(height: 180)
            .aspectRatio(contentMode: .fit)
        Spacer()
    }
}
