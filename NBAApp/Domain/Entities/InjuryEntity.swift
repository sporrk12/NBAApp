//
//  InjuryEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct InjuryEntity: Entity {
    let status: String
    let date: String
    let athlete: AthleteEntity
    let type: TypeEntity
    let details: InjuryDetailEntity
    
    static var defaultValue: InjuryEntity {
        .init(
            status: "",
            date: "",
            athlete: .defaultValue,
            type: .defaultValue,
            details: .defaultValue
        )
    }
}
