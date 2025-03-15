//
//  CompetitorEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct CompetitorEntity: Entity {
    let id: String
    let homeAway: String
    let winner: Bool
    let team: TeamEntity
    let score: String
    let lineScores: CountedListEntity<LineScoreEntity>
    let statistics: CountedListEntity<StatisticsEntity>
    let leaders: CountedListEntity<LeaderEntity>
    let records: CountedListEntity<RecordEntity>
    
    static var defaultValue: CompetitorEntity {
        .init(
            id: "",
            homeAway: "",
            winner: false,
            team: .defaultValue,
            score: "",
            lineScores: .defaultValue,
            statistics: .defaultValue,
            leaders: .defaultValue,
            records: .defaultValue
        )
    }
}
