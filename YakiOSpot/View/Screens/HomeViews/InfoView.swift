//
//  InfoView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink {
                        // TODO: Add a web view
                        Text("Link destination")
                    } label: {
                        HStack {
                            Text(SampleText.membership)
                                .foregroundColor(.red)
                            Spacer()
                            Text("29€/an")
                                .foregroundColor(.secondary)
                        }
                    }

                } header: {
                    Text("Adhésion")
                }
                
                Section {
                    Text(SampleText.spotInfo)
                } header: {
                    Text("Infos")
                }
                
                Section {
                    Text(SampleText.spotOpen)
                } header: {
                    Text("Ouverture")
                }
                
                Section {
                    ForEach(DummySpot.cornillon.tracks, id: \.self) { track in
                        NavigationLink(destination: Text(track.name)) {
                            HStack {
                                Image(systemName: "flag.fill")
                                    .foregroundColor(track.difficulty.color)
                                Spacer()
                                Text(track.name)
                                Spacer()
                                HStack {
                                    Image(systemName: "hand.thumbsup.fill")
                                        .foregroundColor(.blue)
                                    Text("\(track.likes)")
                                }
                            }
                        }
                    }
                } header: {
                    Text("Pistes")
                }
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
                        NavigationLink(destination: Text("Profile")) {
                            Image(systemName: "person.circle")
                                .foregroundColor(.black)
                        }
                    }
                }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
