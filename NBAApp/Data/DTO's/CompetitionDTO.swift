//
//  CompetitionDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class CompetitionDTO: DTO {
    private(set) var venue: VenueDTO
    private(set) var competitors: CountedListDTO<CompetitorDTO>
    private(set) var status: StatusDTO
    private(set) var highlights: CountedListDTO<HighlightDTO>
    private(set) var headlines: CountedListDTO<HeadlineDTO>
    
    init(venue: VenueDTO, competitors: CountedListDTO<CompetitorDTO>, status: StatusDTO, highlights: CountedListDTO<HighlightDTO>, headlines: CountedListDTO<HeadlineDTO>) {
        self.venue = venue
        self.competitors = competitors
        self.status = status
        self.highlights = highlights
        self.headlines = headlines
    }
    
    func toEntity() -> CompetitionEntity {
        return .init(
            venue: self.venue.toEntity(),
            competitors: .init(
                count: self.competitors.count,
                items: self.competitors.items.compactMap { $0.toEntity() }
            ),
            status: self.status.toEntity(),
            highlights: .init(
                count: self.highlights.count,
                items: self.highlights.items.compactMap { $0.toEntity() }
            ),
            headlines: .init(
                count: self.headlines.count,
                items: self.headlines.items.compactMap { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: CompetitionDTO {
        .init(
            venue: .defaultValue,
            competitors: .defaultValue,
            status: .defaultValue,
            highlights: .defaultValue,
            headlines: .defaultValue)
    }
    
}

extension CompetitionDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> CompetitionDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let competitors: CountedListDTO<CompetitorDTO> = CompetitorDTO.toList(fromData: data.getArray(key: "competitors")) ?? .defaultValue
            
            let highlights: CountedListDTO<HighlightDTO> = HighlightDTO.toList(fromData: data.getArray(key: "highlights")) ?? .defaultValue
            
            let headlines: CountedListDTO<HeadlineDTO> = HeadlineDTO.toList(fromData: data.getArray(key: "headlines")) ?? .defaultValue
            
            return .init(
                venue: .toObject(fromData: data.getDictionary(key: "venue")) ?? .defaultValue,
                competitors: competitors,
                status: .toObject(fromData: data.getDictionary(key: "status")) ?? .defaultValue,
                highlights: highlights,
                headlines: headlines
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<CompetitionDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [CompetitionDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [CompetitionDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: CompetitionDTO = .toObject(fromData: data) {
                    dtos.append(dto)
                }
            }
            return .init(
                count: data.getInt(key: "count"),
                items: dtos
            )
        }
        return nil
    }
}
