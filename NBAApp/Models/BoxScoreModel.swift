//
//  BoxScoreModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import Foundation

struct BoxScoreModel: Codable {
    let gameID: String
    let homeTeam: TeamModel
    let awayTeam: TeamModel

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case homeTeam = "home_team"
        case awayTeam = "away_team"
    }
}
