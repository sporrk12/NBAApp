//
//  GameModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 27/01/25.
//

import Foundation

struct GameModel: Codable {
    let id: String
    let date: String
    let status: String
    let homeTeam: TeamModel
    let awayTeam: TeamModel
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case status = "status"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}
