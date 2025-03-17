//
//  NewEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

struct NewEntity: Entity {
    let dataSourceIdentifier: String
    let type: String
    let headline: String
    let description: String
    let published: String
    let images: CountedListEntity<ImageEntity>
    let links: VideoLinkEntity
    
    static var defaultValue: NewEntity {
        .init(
            dataSourceIdentifier: "",
            type: "",
            headline: "",
            description: "",
            published: "",
            images: .defaultValue,
            links: .defaultValue
        )
    }
}

