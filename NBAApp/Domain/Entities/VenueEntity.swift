//
//  VenueEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct VenueEntity: Entity {
    let id: String
    let fullName: String
    let address: AddressEntity
    
    static var defaultValue: VenueEntity {
        .init(
            id: "",
            fullName: "",
            address: .defaultValue
        )
    }
    
}
