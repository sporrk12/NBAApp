//
//  HeadlineEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct HeadlineEntity: Entity {
    let type: String
    let description: String
    let shortLinkText: String
    let video: VideoEntity
    
    static var defaultValue: HeadlineEntity {
        .init(
            type: "",
            description: "",
            shortLinkText: "",
            video: .defaultValue
        )
    }
}
