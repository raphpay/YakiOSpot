//
//  Date+Ext.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 26/01/2022.
//

import Foundation

extension Date {
    func getRelativeDateFromNow() -> String {
        
        // Ask for the full relative date
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        
        // Get exampleDate relative to the current date
        let relativeDate = formatter.localizedString(for: self, relativeTo: Date())
        
        return relativeDate
    }
}
