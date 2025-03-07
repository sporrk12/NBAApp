//
//  PlayersDetailsResponseModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

struct PlayerDetailsResponse: Decodable {
    let player: PlayerModel
    let careerStats: [CareerStatsModel]
}
