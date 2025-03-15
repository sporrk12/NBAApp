//
//  RecordEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct RecordEntity: Entity {
    let name: String
    let abbreviation: String
    let type: String
    let summary: String
    
    static var defaultValue: RecordEntity {
        .init(
            name: "",
            abbreviation: "",
            type: "",
            summary: ""
        )
    }
}
