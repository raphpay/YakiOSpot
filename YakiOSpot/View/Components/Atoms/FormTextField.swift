//
//  FormTextField.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 22/11/2021.
//

import SwiftUI

struct FormTextField: View {
    var isSecured: Bool  = false
    let placeholder: String
    var text: Binding<String>
    var submitLabel: SubmitLabel = .next
    var onCommit: (() -> Void)
    
    
    var body: some View {
        if isSecured {
            SecureField("Mot de passe", text: text, onCommit: onCommit)
                .frame(height: 55)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
        } else {
            TextField(placeholder, text: text, onCommit: onCommit)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .submitLabel(submitLabel)
        }
    }
}
