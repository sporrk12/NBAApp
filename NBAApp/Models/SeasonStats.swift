//
//  SeasonStats.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 30/01/25.
//

import Foundation

struct SeasonStats: Decodable {
    let season: String
    let points: Double
    let assists: Double
    let rebounds: Double
    let PIE: Double
    
    enum CodingKeys: String, CodingKey {
        
        case season
        case points
        case assists
        case rebounds
        case PIE
        
    }
}
