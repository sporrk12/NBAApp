//
//  GameEventEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct GameEventEntity: Entity {
    let id: String
    let atVs: String
    let gameDate: String
    let score: String
    let homeTeamId: String
    let awayTeamId: String
    let homeTeamScore: String
    let awayTeamScore: String
    let gameResult: String
    let opponent: TeamEntity
    
    static var defaultValue: GameEventEntity {
        .init(
            id: "",
            atVs: "",
            gameDate: "",
            score: "",
            homeTeamId: "",
            awayTeamId: "",
            homeTeamScore: "",
            awayTeamScore: "",
            gameResult: "",
            opponent: .defaultValue
        )
    }
}

