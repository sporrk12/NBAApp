//
//  VideoLinkEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct VideoLinkEntity: Entity {
    
    let mobileURL: String
    let apiURL: String
    
    static var defaultValue: VideoLinkEntity {
        .init(
            mobileURL: "",
            apiURL: ""
        )
    }
}
