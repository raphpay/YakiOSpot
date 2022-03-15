//
//  ProfileSection.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 29/01/2022.
//

import SwiftUI

struct ProfileSection<Content: View>: View {
    
    let title: String
    let action: (() -> Void)?
    let content: Content
    
    init(title: String = "Mon statut", @ViewBuilder content: () -> Content, action: (() -> Void)? = nil) {
        self.title = title
        self.content = content()
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                if action != nil {
                    Button {
                        action?()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .padding(.top, 24)
            .padding(.horizontal)
            
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
