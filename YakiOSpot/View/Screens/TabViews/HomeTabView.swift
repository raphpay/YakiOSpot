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
                            changeTab(number)
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
                    viewModel.showAlert.toggle()
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
        .alert(isUserPresent ? "Tu confirme ne plus être au spot ?" : "Tu confirme être au spot ?",
               isPresented: $viewModel.showAlert) {
            Button {
                viewModel.toggleUserPresence()
            } label: {
                Text(isUserPresent ? "Tu t'en vas déjà ?" : "Tu es vraiment au spot ?")
            }
            
            Button {} label: {
                Text(isUserPresent ? "Non, je reste !" : "Non, je ne suis pas au spot")
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
