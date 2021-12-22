//
//  HomeView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import SwiftUI

struct HomeTabView: View {
    
    @ObservedObject private var viewModel = HomeTabViewViewModel()
    @ObservedObject var appState: AppState
    @AppStorage(DefaultKeys.IS_USER_PRESENT) var isUserPresent: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                switch viewModel.selectedIndex {
                case 0:
                    InfoView(appState: appState)
                case 1:
                    FeedView()
                case 2:
                    FeedView()
                default:
                    Text("Another screen")
                }
            }
            
            ZStack {
                HStack {
                    ForEach(0..<viewModel.icons.count, id: \.self) { number in
                        Spacer()
                        Button {
                            print("======= \n tap selectedIndex : \(number) \n=====")
                            if number == 1 {
                                appState.showButton.toggle()
                            } else {
                                viewModel.selectedIndex = number
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
                                        .foregroundColor(viewModel.selectedIndex == number ? .blue : .secondary)
                                        .frame(width: 60)
                                    Text(viewModel.titles[number])
                                        .foregroundColor(viewModel.selectedIndex == number ? .blue : .secondary)
                                }
                            }
                        }.padding(.top, 20)
                        Spacer()
                    }
                }
                Button {
                    guard let user = API.User.CURRENT_USER_OBJECT else { return }
                    API.User.session.toggleUserPresence(user) { isPresent in
                        // Show alert
                    } onError: { error in
                        // Show alert
                        print("error", error)
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

