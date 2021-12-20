//
//  HomeView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct HomeTabView: View {
    
    let icons = ["info.circle", "hand.raised.fill", "bicycle"]
    let titles = ["Info", "", "Feed"]
    
    var body: some View {
        TabView {
            InfoView()
                .tabItem {
                    Label("Infos", systemImage: "info.circle")
                }
            FeedView()
                .tabItem {
                    Label("Feed", systemImage: "bicycle")
                }
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
