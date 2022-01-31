//
//  LoadingText.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 31/01/2022.
//

import SwiftUI

struct LoadingText: View {
    
    // TODO: Add smooth animations on text
    let text = "Sauvegarde"
    @State private var dots = ""
    let timer = Timer.publish(every: 0.6, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Text("\(text)\(dots)")
            .font(.system(size: 18))
            .fontWeight(.medium)
            .transition(.slide)
            .onReceive(timer) { _ in
                if self.dots.count == 3 {
                    self.dots = ""
                } else {
                    self.dots += "."
                }
            }
    }
}
