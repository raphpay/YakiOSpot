//
//  AlertView.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 19/02/2022.
//

import SwiftUI

struct AlertView<Content: View>: View {
    
    @Binding var showAlert: Bool
    
    let alertTitle: String
    let message: String?
    let content: Content
    
    init(alertTitle: String, alertMessage: String? = nil, showAlert: Binding<Bool>,  @ViewBuilder content: () -> Content) {
        self.alertTitle = alertTitle
        self.message = alertMessage
        self._showAlert = showAlert
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            VStack() {
                Text(alertTitle)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                
                if let alertMessage = message {
                    Text(alertMessage)
                        .font(.system(size: 14))
                }
                
                content
            }
            .padding(.top)
            .frame(width: 250)
            .background(Color.white)
            .mask(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.3))
        .edgesIgnoringSafeArea(.all)
    }
}
