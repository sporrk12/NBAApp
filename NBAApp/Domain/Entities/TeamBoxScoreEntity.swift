//
//  TeamBoxScoreEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

struct TeamBoxScoreEntity: Entity {
    let team: TeamEntity
    let statistics: CountedListEntity<StatisticsEntity>
    let displayOrder: String
    let homeAway: String
    
    static var defaultValue: TeamBoxScoreEntity {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: "",
            homeAway: ""
        )
    }
}
