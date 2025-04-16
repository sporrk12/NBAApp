//
//  LeagueEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

struct LeagueEntity: Entity {
    let id: String
    let name: String
    let abbreviation: String
    let year: Int
    let season: String
    let teams: CountedListEntity<TeamEntity>
    
    static var defaultValue: LeagueEntity {
        .init(
            id: "",
            name: "",
            abbreviation: "",
            year: 0,
            season: "",
            teams: .defaultValue
        )
    }
}

