//
//  StatEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/04/25.
//

import Foundation

struct StatEntity: Entity {
    let name: String
    let value: String

    static var defaultValue: StatEntity {
        .init(name: "", value: "")
    }
}
