//
//  PlayerModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 28/01/25.
//

import Foundation

struct PlayerModel: Codable {
    let id: Int
    let name: String
    let height: String?
    let weight: String?
    let position: String?
    let points: Int?
    let rebounds: Int?
    let assists: Int?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case weight
        case position
        case points
        case rebounds
        case assists
        case imageURL = "image_url"
    }
}
