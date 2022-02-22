//
//  InfoView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct InfoView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    MembershipRow(link: URL(string: SampleText.annualLink)!,
                                  description: SampleText.annualMembership, price: SampleText.annualPrice)
                    MembershipRow(link: URL(string: SampleText.dayLink)!,
                                  description: SampleText.dailyMembership, price: SampleText.dayPrice)
                } header: {
                    Text(SampleText.membership)
                        .foregroundColor(.red)
                }
                
                Section {
                    Text(SampleText.spotInfo1)
                    Text(SampleText.spotInfo2)
                    Text(SampleText.spotInfo3)
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
                        NavigationLink(destination: TrackView(viewModel: TrackViewViewModel(track: track))) {
                            TrackRow(track: track)
                        }
                    }
                } header: {
                    Text("Pistes")
                }
            }
            .navigationBarTitle("DCF Cornillon")
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


// MARK: - Subviews
struct MembershipRow : View {
    let link : URL
    let description: String
    let price: String
    
    var body: some View {
        Link(destination: link) {
            HStack {
                Text(description)
                Spacer()
                Text(price)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct TrackRow: View {
    let track: Track
    
    var body: some View {
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
