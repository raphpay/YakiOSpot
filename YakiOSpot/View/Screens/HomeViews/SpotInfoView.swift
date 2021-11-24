//
//  InfosSubview.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import SwiftUI

struct SpotInfoView: View {
    private let infos = "Toutes info importante sera consignée ici :\n- Annonces,\n- Contest / Jam\n- Fermeture exceptionnelle\n- Autres"
    
    var tracks: [Track]
    
    var body: some View {
        Form {
            Section {
                Text(infos)
            } header: {
                Text("Informations importantes")
            }
            
            Section {
                Text("Ouvert tous les jours")
            } header: {
                Text("Ouverture")
            }
            Section {
                ForEach(tracks, id: \.self) { track in
                    TrackRowView(track: track)
                }
            } header: {
                Text("Les pistes")
            }
        }
    }
}

struct InfosSubview_Previews: PreviewProvider {
    static var previews: some View {
        SpotInfoView(tracks: Track.mockTracks)
    }
}
