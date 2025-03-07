//
//  LiveGamesModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 27/01/25.
//

import Foundation

struct LiveGamesModel: Codable {
    let date: String
    let games: [GameModel]
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case games = "games"
    }
}
