//
//  StatusEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct StatusEntity: Entity{
    let displayClock: String
    let period: Int
    let type: TypeEntity
    
    static var defaultValue: StatusEntity{
        .init(
            displayClock: "",
            period: 0,
            type: .defaultValue
        )
    }
}
