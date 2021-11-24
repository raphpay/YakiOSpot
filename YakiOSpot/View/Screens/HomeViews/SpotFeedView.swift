//
//  SpotFeedView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/11/2021.
//

import SwiftUI

struct SpotFeedView: View {
    var body: some View {
        Form {
            Section {
                Text("6 personnes présentes")
            } header: {
                Text("Personnes présentes")
            }
            
            Section {
                PostView()
            }
        }
    }
}

struct SpotFeedView_Previews: PreviewProvider {
    static var previews: some View {
        SpotFeedView()
    }
}
