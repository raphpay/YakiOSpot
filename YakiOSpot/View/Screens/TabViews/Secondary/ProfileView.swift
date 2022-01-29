//
//  ProfileView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 15/11/2021.
//

import SwiftUI

struct ProfileView: View {
    @AppStorage("pseudo") var pseudo: String = ""
    @Binding var isConnected: Bool
    private let imageSize = CGFloat(85)
    
    var body: some View {
        ScrollView {
            VStack {
                profileRow
                
                ProfileSection {
                    HStack {
                        StatusButton()
                        Spacer()
                        StatusButton(title: "🚶‍♂️ Plus au spot", color: .red, isSelected: false)
                    }
                    .padding(.horizontal)
                }
                
                ProfileSection(title: "Mes sessions") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            SessionCard()
                            SessionCard()
                            SessionCard()
                        }
                        .padding(.horizontal)
                    }
                } action: {
                    print("Hello world")
                }
                
                
                ProfileSection(title: "Mon bike") {
                    BikeCard()
                        .padding(.horizontal)
                }
            }
        }
            .navigationTitle("Profil")
    }
    
    var profileRow: some View {
        HStack(alignment: .center, spacing: 28) {
            Image(Assets.imagePlaceholder)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .aspectRatio(contentMode: .fill)
                .mask(Circle())
//                .overlay(BadgeIcon(), alignment: .topTrailing)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(pseudo)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Rider")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            NavigationLink(destination: Text("Hello World")) {
                Image(systemName: "highlighter")
                    .font(.system(size: 25))
                    .foregroundColor(.secondary)
            }

        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal)
    }
    
    func didTapLogOut() {
        API.Auth.session.signOut {
            isConnected = false
        } onError: { error in
            isConnected = true
        }
    }
}
