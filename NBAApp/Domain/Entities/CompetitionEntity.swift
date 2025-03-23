//
//  CompetitionEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

struct CompetitionEntity: Entity {
    let date: String
    let venue: VenueEntity
    let competitors: CountedListEntity<CompetitorEntity>
    let status: StatusEntity
    let highlights: CountedListEntity<HighlightEntity>
    let headlines: CountedListEntity<HeadlineEntity>
    
    static var defaultValue: CompetitionEntity {
        .init(
            date: "",
            venue: .defaultValue,
            competitors: .defaultValue,
            status: .defaultValue,
            highlights: .defaultValue,
            headlines: .defaultValue)
    }
}
