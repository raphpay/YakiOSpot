//
//  View+Ext.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 24/01/2022.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
