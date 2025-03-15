//
//  BoxScoreEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

struct BoxScoreEntity: Entity {
    let teams: CountedListEntity<TeamBoxScoreEntity>
    let players : CountedListEntity<PlayerBoxScoreEntity>
    
    static var defaultValue: BoxScoreEntity {
        .init(
            teams: .defaultValue,
            players: .defaultValue
        )
    }
}
