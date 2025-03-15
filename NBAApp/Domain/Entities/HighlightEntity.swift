//
//  HighlightEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct HighlightEntity: Entity {
    let id: Int
    let headline: String
    let description: String
    let duration: Int
    let thumbnail: String
    let videoLinks: VideoLinkEntity
 
    static var defaultValue: HighlightEntity {
        .init(
            id: 0,
            headline: "",
            description: "",
            duration: 0,
            thumbnail: "",
            videoLinks: .defaultValue
        )
    }
}
