//
//  RoundedButton.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import SwiftUI

struct RoundedButton : View {
    var title: String
    var width   = CGFloat(150)
    var height  = CGFloat(55)
    var backgroundColor: Color = Color.blue
    var foregroundColor: Color = .white
    
    var body : some View {
        Text(title)
            .frame(width: width, height: height)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}
