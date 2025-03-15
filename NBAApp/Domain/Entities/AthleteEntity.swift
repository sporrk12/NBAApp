//
//  AthleteEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct AthleteEntity: Entity {
    let id: String
    let fullName: String
    let displayName: String
    let shortName: String
    let headshot: String
    let jersey: String
    let position: String
    let team: TeamEntity
    let active: Bool
    
    static var defaultValue: AthleteEntity {
        .init(
            id: "",
            fullName: "",
            displayName: "",
            shortName: "",
            headshot: "",
            jersey: "",
            position: "",
            team: .defaultValue,
            active: false
        )
    }
}
