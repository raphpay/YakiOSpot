//
//  BadgeIcon.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 17/02/2022.
//

import SwiftUI

struct BadgeIcon: View {
    
    @Binding var user: User
    var size = CGFloat(30)
    
    var badgeColor: Color {
        switch user.memberType {
        case .rider:
            return .green
        case .ambassador:
            return .blue
        case .dev:
            return .black
        case .staff:
            return .brown
        default:
            return .red
        }
    }
    var isMember: Bool {
        guard let bool = user.isMember else { return false }
        return bool
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image(systemName: isMember ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .resizable()
                    .frame(width: size, height: size)
//                    .symbolRenderingMode(.hierarchical)
                    .foregroundColor(badgeColor)
            }
            
            Spacer()
        }
    }
}
