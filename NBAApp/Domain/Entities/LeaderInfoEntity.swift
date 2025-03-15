//
//  LeaderInfoEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct LeaderInfoEntity: Entity {
    let displayValue: String
    let athlete: AthleteEntity
    let team: TeamEntity
    
    static var defaultValue: LeaderInfoEntity {
        .init(
            displayValue: "",
            athlete: .defaultValue,
            team: .defaultValue
        )
    }
}
