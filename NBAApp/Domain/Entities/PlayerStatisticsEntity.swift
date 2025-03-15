//
//  PlayerStatisticsEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

struct PlayerStatisticsEntity: Entity {
    let names: StringCountedListEntity
    let keys: StringCountedListEntity
    let labels: StringCountedListEntity
    let descriptions: StringCountedListEntity
    let athletes: CountedListEntity<AthletesEntity>
    let totals: StringCountedListEntity

    static var defaultValue: PlayerStatisticsEntity {
        return .init(
            names: .defaultValue,
            keys: .defaultValue,
            labels: .defaultValue,
            descriptions: .defaultValue,
            athletes: .defaultValue,
            totals: .defaultValue
        )
    }
}
