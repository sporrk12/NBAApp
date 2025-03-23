//
//  TeamEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct TeamEntity: Entity {
    let id: String
    let location: String
    let name: String
    let abbreviation: String
    let displayName: String
    let shortDisplayName: String
    let color: String
    let alternateColor: String
    let isActive: Bool
    let logo: String
    let logos: CountedListEntity<LogoEntity>
    
    static var defaultValue: TeamEntity {
        .init(
            id: "",
            location: "",
            name: "",
            abbreviation: "",
            displayName: "",
            shortDisplayName: "",
            color: "",
            alternateColor: "",
            isActive: false,
            logo: "",
            logos: .defaultValue
        )
    }
}
