//
//  AddressEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct AddressEntity: Entity {
    let city: String
    let state: String
    
    static var defaultValue: AddressEntity{
        .init(
            city: "",
            state: ""
        )
    }
}
