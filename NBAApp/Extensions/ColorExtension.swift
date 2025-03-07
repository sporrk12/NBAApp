//
//  ColorExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 04/03/25.
//

import Foundation
import SwiftUI

extension Color {
    struct Colors {
        private static let teamColors: [String: Color] = [
            "ATL": Color(hex: "#E03A3E"), // Atlanta Hawks
            "BOS": Color(hex: "#007A33"), // Boston Celtics
            "BKN": Color(hex: "#000000"), // Brooklyn Nets
            "CHA": Color(hex: "#1D1160"), // Charlotte Hornets
            "CHI": Color(hex: "#CE1141"), // Chicago Bulls
            "CLE": Color(hex: "#860038"), // Cleveland Cavaliers
            "DAL": Color(hex: "#00538C"), // Dallas Mavericks
            "DEN": Color(hex: "#0E2240"), // Denver Nuggets
            "DET": Color(hex: "#C8102E"), // Detroit Pistons
            "GSW": Color(hex: "#1D428A"), // Golden State Warriors
            "HOU": Color(hex: "#CE1141"), // Houston Rockets
            "IND": Color(hex: "#002D62"), // Indiana Pacers
            "LAC": Color(hex: "#C8102E"), // Los Angeles Clippers
            "LAL": Color(hex: "#552583"), // Los Angeles Lakers
            "MEM": Color(hex: "#5D76A9"), // Memphis Grizzlies
            "MIA": Color(hex: "#98002E"), // Miami Heat
            "MIL": Color(hex: "#00471B"), // Milwaukee Bucks
            "MIN": Color(hex: "#0C2340"), // Minnesota Timberwolves
            "NOP": Color(hex: "#0C2340"), // New Orleans Pelicans
            "NYK": Color(hex: "#006BB6"), // New York Knicks
            "OKC": Color(hex: "#007AC1"), // Oklahoma City Thunder
            "ORL": Color(hex: "#0077C0"), // Orlando Magic
            "PHI": Color(hex: "#006BB6"), // Philadelphia 76ers
            "PHX": Color(hex: "#1D1160"), // Phoenix Suns
            "POR": Color(hex: "#E03A3E"), // Portland Trail Blazers
            "SAC": Color(hex: "#5A2D81"), // Sacramento Kings
            "SAS": Color(hex: "#C4CED4"), // San Antonio Spurs
            "TOR": Color(hex: "#CE1141"), // Toronto Raptors
            "UTA": Color(hex: "#002B5C"), // Utah Jazz
            "WAS": Color(hex: "#002B5C")  // Washington Wizards
        ]
        
        static func team(_ abbreviation: String) -> Color {
            return teamColors[abbreviation, default: Color.gray] // Usa gris si no encuentra el equipo
        }
    }
}

// Extensión para inicializar colores desde HEX
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#") // Omitimos el "#"
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}
