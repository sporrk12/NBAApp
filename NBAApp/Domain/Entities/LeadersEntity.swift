//
//  LeadersEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct LeadersEntity: Entity {
    let team: TeamEntity
    let leaders: CountedListEntity<LeaderEntity>
    
    static var defaultValue: LeadersEntity {
        .init(
            team: .defaultValue,
            leaders: .defaultValue)
    }
    
}
