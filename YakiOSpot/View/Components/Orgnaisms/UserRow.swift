//
//  ProfileRow.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 30/01/2022.
//

import SwiftUI

struct UserRow: View {
    
    @Binding var user: User
    private let imageSize = CGFloat(85)
    
    var body: some View {
        HStack(alignment: .center, spacing: 28) {
            Image(Assets.imagePlaceholder)
                .resizable()
                .frame(width: imageSize, height: imageSize)
                .aspectRatio(contentMode: .fill)
                .mask(Circle())
//                .overlay(BadgeIcon(), alignment: .topTrailing)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user.pseudo)
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
}
