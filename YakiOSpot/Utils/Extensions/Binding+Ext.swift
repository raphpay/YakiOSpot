//
//  Binding+Ext.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 19/02/2022.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
