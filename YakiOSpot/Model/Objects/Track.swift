//
//  Track.swift
//  YakiOSpot
//
//  Created by Raphaël Payet on 10/12/2021.
//

import Foundation
import SwiftUI

struct Track: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let difficulty: Difficulty
    let likes: Int
    let distance: Double?
    let averageTime: Double? // In seconds
    var videoURL: URL?
    
    enum Difficulty: Codable {
        case green, blue, red, black, diamond
        
        var color: Color {
            switch self {
            case .green:
                return Color.green
            case .blue:
                return Color.blue
            case .red:
                return Color.red
            case .black:
                return Color.black
            case .diamond:
                return Color.black
            }
        }
        var description: String {
            switch self {
            case .green:
                return "Verte"
            case .blue:
                return "Bleue"
            case .red:
                return "Rouge"
            case .black:
                return "Noire"
            case .diamond:
                return "Double-Noire"
            }
        }
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
