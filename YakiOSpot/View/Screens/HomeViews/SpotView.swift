//
//  SpotView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct SpotView: View {
    
    var spot: Spot
    @State var selection: Int = 0
    
    private let infos = "Toutes info importante sera consignée ici :\n- Annonces,\n- Contest / Jam\n- Fermeture exceptionnelle\n- Autres"
    
    var tracks: [String] = ["Piste 1", "Piste 2", "Piste 3"]
    
    var body: some View {
        VStack {
            Picker("Selection", selection: $selection) {
                Text("Infos importantes").tag(0)
                Text("Feed").tag(1)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            
            if selection == 0 {
                
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
                            Text(track)
                        }
                    } header: {
                        Text("Les pistes")
                    }
                }
                
                
                
            } else if selection == 1 {
                Text("Feed")
            }
            Spacer()
        }.navigationTitle(spot.name)
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot.dummySpot)
    }
}
