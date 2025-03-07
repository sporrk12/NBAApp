//
//  FiveLastGamesModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

struct Last5GamesResponse: Decodable {
    let playerID: String
    let last5Games: [GameLogModel]
    
    enum CodingKeys: String, CodingKey {
        case playerID = "player_id"
        case last5Games = "last_5_games"
    }
}
