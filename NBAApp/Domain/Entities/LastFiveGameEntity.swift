//
//  LastFiveGameEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

struct LastFiveGameEntity: Entity {
    let displayOrder: Int
    let team: TeamEntity
    let events: CountedListEntity<GameEventEntity>
    
    static var defaultValue: LastFiveGameEntity {
        .init(
            displayOrder: 0,
            team: .defaultValue,
            events: .defaultValue
        )
    }
}


