//
//  SportEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

struct SportEntity: Entity {
    let id: String
    let name: String
    let leagues: CountedListEntity<LeagueEntity>
    
    static var defaultValue: SportEntity {
        .init(
            id: "",
            name: "",
            leagues: .defaultValue
        )
    }
}

