//
//  InjuryDetailEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

struct InjuryDetailEntity: Entity {
    let type: String
    let location: String
    let detail: String
    let side: String
    let returnDate: String
    
    static var defaultValue: InjuryDetailEntity {
        .init(
            type: "",
            location: "",
            detail: "",
            side: "",
            returnDate: ""
        )
    }
}
