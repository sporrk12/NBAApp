//
//  LeaderEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct LeaderEntity: Entity {
    let name: String
    let displayName: String
    let shortDisplayName: String
    let abbreviation: String
    let leaderInfo: LeaderInfoEntity
    
    static var defaultValue: LeaderEntity {
        .init(
            name: "",
            displayName: "",
            shortDisplayName: "",
            abbreviation: "",
            leaderInfo: .defaultValue
        )
    }
}
