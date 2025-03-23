//
//  HeaderEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

struct HeaderEntity: Entity {
    let id: String
    let timeValid: Bool
    let competititons: CountedListEntity<CompetitionEntity>
    
    static var defaultValue: HeaderEntity {
        .init(
            id: "",
            timeValid: false,
            competititons: .defaultValue
        )
    }
}
