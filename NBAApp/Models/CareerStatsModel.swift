//
//  CareerStatsModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

struct CareerStatsModel: Decodable {
    let season: String
    let gamesPlayed: Int
    let gamesStarted: Int
    let minutes: Double
    let points: Double
    let rebounds: Double
    let assists: Double
    let steals: Double
    let blocks: Double
    let turnovers: Double
    let teamAbbreviation: String
}
