//
//  EventEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct EventEntity: Entity {
    let id: String
    let date: String
    let name: String
    let shortName: String
    let competitions: CountedListEntity<CompetitionEntity>
    let status: StatusEntity
    
    static var defaultValue: EventEntity{
        .init(
            id: "",
            date: "",
            name: "",
            shortName: "",
            competitions: .defaultValue,
            status: .defaultValue
        )
    }
}
