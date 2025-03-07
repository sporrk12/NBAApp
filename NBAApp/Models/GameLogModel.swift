//
//  GameLogModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

struct GameLogModel: Decodable {
    let date: String
    let points: Double
    let rebounds: Double
    let assists: Double
    let homeTeam: String
    let awayTeam: String
    let homeTeamLogo: String
    let awayTeamLogo: String
}
