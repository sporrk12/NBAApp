//
//  TeamModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 27/01/25.
//

import Foundation
import SwiftUI

struct TeamModel: Codable {
    let id: Int
    let name: String
    let abbreviation: String
    let city: String?
    let logoURL: String?
    let score: Int?
    let players: [PlayerModel]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case abbreviation = "abbreviation"
        case city = "city"
        case logoURL = "logo_url"
        case score = "score"
        case players = "players"
    }
}

extension TeamModel {
    var primaryColor: Color {
        return Color.Colors.team(abbreviation)
    }
}
