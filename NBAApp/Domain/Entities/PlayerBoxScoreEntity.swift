//
//  PlayerBoxScoreEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

struct PlayerBoxScoreEntity: Entity {
    let team: TeamEntity
    let statistics: CountedListEntity<PlayerStatisticsEntity>
    let displayOrder: String
    
    static var defaultValue: PlayerBoxScoreEntity {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: ""
        )
    }
}
