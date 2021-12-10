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
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Selection", selection: $selection) {
                                Text("Infos importantes").tag(0)
                                Text("Feed").tag(1)
                            }
                            .pickerStyle(.segmented)
                            .padding(.horizontal)
                Spacer()
            }
            .navigationTitle(spot.name)
        }
    }
}

struct SpotView_Previews: PreviewProvider {
    static var previews: some View {
        SpotView(spot: Spot(id: UUID().uuidString, name: "Spot", tracks: [
            Track(id: UUID().uuidString, name: "Track", difficulty: .blue, likes: 0, distance: 0, averageTime: 0)],
                            members: 0, peoplePresent: 0))
    }
}
