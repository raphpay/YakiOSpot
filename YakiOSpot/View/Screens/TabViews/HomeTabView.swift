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
    @ObservedObject var appState: AppState
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            ZStack {
                switch selectedIndex {
                case 0:
                    InfoView(appState: appState)
                case 2:
                    FeedView(appState: appState)
                default:
                    Text("Another screen")
                }
            }
            
            ZStack {
                HStack {
                    ForEach(0..<viewModel.icons.count, id: \.self) { number in
                        Spacer()
                        Button {
                            if number == 1 {
                                appState.showButton.toggle()
                            } else {
                                selectedIndex = number
                                appState.showButton = false
                            }
                        } label: {
                            if number == 1 {
                                Image(systemName: viewModel.icons[number])
                                    .font(.system(size: 25, weight: .regular, design: .default))
                                    .foregroundColor(.white)
                                    .frame(width: 60, height: 60)
                                    .background(Color.blue)
                                    .cornerRadius(30)
                                    .offset(y: -40)
                            } else {
                                VStack {
                                    Image(systemName: viewModel.icons[number])
                                        .font(.system(size: 25, weight: .regular, design: .default))
                                        .foregroundColor(selectedIndex == number ? .blue : .secondary)
                                        .frame(width: 60)
                                    Text(viewModel.titles[number])
                                        .foregroundColor(selectedIndex == number ? .blue : .secondary)
                                }
                            }
                        }.padding(.top, 20)
                        Spacer()
                    }
                }
                Button {
                    guard let user = API.User.CURRENT_USER_OBJECT else { return }
                    API.User.session.toggleUserPresence(user) {
                        API.Spot.session.getSpot { spot in
                            API.Spot.session.toggleUserPresence(from: spot, user: user) {
                                print("toggleUserPresence success")
                            } onError: { error in
                                print("toggleUserPresence error")
                            }
                        } onError: { error in
                            print("getSpot", error)
                        }
                    } onError: { error in
                        // Show alert
                        print("getSpot toggleUserPresence error")
                    }
                } label: {
                    Text(isUserPresent ? "Je m'en vais !" : "Je suis là !")
                        .frame(width: 150, height: 55)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .offset(y: appState.showButton ? -100 : 0)
                .opacity(appState.showButton ? 1 : 0)
                .animation(.easeInOut(duration: 0.25), value: appState.showButton)
            }
        }
    }
}

