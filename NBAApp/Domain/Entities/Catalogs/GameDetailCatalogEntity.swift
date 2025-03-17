//
//  GameDetailCatalogEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

struct GameDetailCatalogEntity: Entity {
    let boxscore: BoxScoreEntity
    let venue: VenueEntity
    let lastFiveGames: CountedListEntity<LastFiveGameEntity>
    let leaders: CountedListEntity<LeadersEntity>
    let injuries: CountedListEntity<InjuriesEntity>
    let predictor: PredictorEntity
    let news: CountedListEntity<NewEntity> //TODO: Revisar como se obtienen los datos y ver si es necesario agregar HEADER
    let videos: CountedListEntity<VideoEntity>
    
    
    static var defaultValue: GameDetailCatalogEntity {
        .init(
            boxscore: .defaultValue,
            venue: .defaultValue,
            lastFiveGames: .defaultValue,
            leaders: .defaultValue,
            injuries: .defaultValue,
            predictor: .defaultValue,
            news: .defaultValue,
            videos: .defaultValue
        )
    }
}
