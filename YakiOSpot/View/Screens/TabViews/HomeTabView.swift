//
//  HomeView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct HomeTabView: View {
    @AppStorage(DefaultKeys.IS_USER_PRESENT) var isUserPresent: Bool = false
    @ObservedObject private var viewModel = HomeTabViewViewModel()
    @EnvironmentObject var appState: AppState
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        TabView {
            YakiView(appState: appState)
                .tabItem {
                    Label("Yaki", systemImage: "bicycle")
                }
            
            InfoView(appState: appState)
                .tabItem {
                    Label("Infos", systemImage: "info.circle")
                }
        }
    }
}


// MARK: - Private methods
extension HomeTabView {
    func changeTab(_ index: Int) {
        if index == 1 {
            appState.showButton.toggle()
        } else {
            selectedIndex = index
            appState.showButton = false
        }
    }
}
