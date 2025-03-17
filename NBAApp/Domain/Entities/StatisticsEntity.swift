//
//  StatisticsEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct StatisticsEntity: Entity {
    let name: String
    let displayName: String
    let abbreviation: String
    let displayValue: String
    let label: String
    
    static var defaultValue: StatisticsEntity {
        .init(
            name: "",
            displayName: "",
            abbreviation: "",
            displayValue: "",
            label: ""
        )
    }
}
