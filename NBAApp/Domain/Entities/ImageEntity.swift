//
//  ImageEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

struct ImageEntity: Entity {
    let name: String
    let caption: String
    let height: String
    let width: String
    let url: String
    
    static var defaultValue: ImageEntity {
        .init(
            name: "",
            caption: "",
            height: "",
            width: "",
            url: ""
        )
    }
}
