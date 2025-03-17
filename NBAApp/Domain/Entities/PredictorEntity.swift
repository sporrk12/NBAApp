//
//  PredictorEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

struct PredictorEntity: Entity {
    let header: String
    let homeProjection: String
    let awayProjection: String
    
    static var defaultValue: PredictorEntity {
        .init(
            header: "",
            homeProjection: "",
            awayProjection: ""
        )
    }
}

