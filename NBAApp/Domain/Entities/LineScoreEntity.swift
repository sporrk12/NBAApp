//
//  LineScoreEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct LineScoreEntity: Entity {
    let value: Double
    
    static var defaultValue: LineScoreEntity {
        .init(
            value: 0.0
        )
    }
}
