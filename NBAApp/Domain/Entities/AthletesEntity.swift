//
//  AthletesEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

struct AthletesEntity: Entity {
    let active: Bool
    let athlete: AthleteEntity
    let starter: Bool
    let didNotPlay: Bool
    let reason: String
    let ejected: Bool
    let stats: StringCountedListEntity
    
    static var defaultValue: AthletesEntity {
        .init(
            active: false,
            athlete: .defaultValue,
            starter: false,
            didNotPlay: false,
            reason: "",
            ejected: false,
            stats: .defaultValue
        )
    }
}


