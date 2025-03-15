//
//  VideoEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct VideoEntity: Entity {
    let id: Int
    let headline: String
    let thumbnail: String
    let duration: Int
    let videoLinks: VideoLinkEntity
    
    static var defaultValue: VideoEntity {
        .init(
            id: 0,
            headline: "",
            thumbnail: "",
            duration: 0,
            videoLinks: .defaultValue
        )
    }
}
