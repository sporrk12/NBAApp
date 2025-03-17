//
//  InjuriesEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct InjuriesEntity: Entity {
    let team: TeamEntity
    let injuries: CountedListEntity<InjuryEntity>
    
    static var defaultValue: InjuriesEntity {
        .init(
            team: .defaultValue,
            injuries: .defaultValue
        )
    }
}
