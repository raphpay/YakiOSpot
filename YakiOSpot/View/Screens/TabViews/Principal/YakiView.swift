//
//  YakiView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 03/01/2022.
//

import SwiftUI

struct YakiView: View {
    
    @EnvironmentObject var appState: AppState
    @ObservedObject private var viewModel = YakiViewViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(SampleText.features)
                    .font(.system(size: 16, weight: .regular))
                    .multilineTextAlignment(.center)

                List {
                    Section {
                        if viewModel.peoplePresent.isEmpty {
                            Text("Personne au spot pour le moment !")
                        } else {
                            ForEach(viewModel.peoplePresent, id: \.self) { person in
                                Text(person.pseudo)
                                    .font(.system(size: 20))
                            }
                        }
                    } header: {
                        Text("Personnes présentes")
                    }
                    
                    Section {
                        if viewModel.sessions.isEmpty {
                            Text("Pas de sessions prévues pour le moment")
                        } else {
                            ForEach(viewModel.sessions, id: \.self) { session in
                                NavigationLink(destination: SessionView(viewModel: SessionViewViewModel(session: session))) {
                                    VStack(alignment: .leading) {
                                        Text("Nouvelle session prévue \(session.date.getRelativeDateFromNow())")
                                        Text("Par : \(session.creator.pseudo)")
                                    }
                                }
                            }
                        }
                    } header: {
                        Text("Sessions prévues")
                    }
                }
            }
            .navigationTitle("Yaki O Spot")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProfileView()) {
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
        VStack(alignment: .center) {
            Text(SampleText.noPeople)
                .font(.system(size: 16, weight: .bold))
                .multilineTextAlignment(.center)
            Image(Assets.noPeople)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            Spacer()
        }
    }
}
