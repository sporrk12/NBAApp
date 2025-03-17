//
//  TypeEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct TypeEntity: Entity {
    let id: String
    let name: String
    let state: String
    let completed: Bool
    let description: String
    let detail: String
    let shortDetail: String
    let abbreviation: String
    
    static var defaultValue: TypeEntity{
        .init(
            id: "",
            name: "",
            state: "",
            completed: false,
            description: "",
            detail: "",
            shortDetail: "",
            abbreviation: ""
        )
    }
}
