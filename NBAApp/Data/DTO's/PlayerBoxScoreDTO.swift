//
//  PlayerBoxScoreDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

class PlayerBoxScoreDTO: DTO {
    private(set) var team: TeamDTO
    private(set) var statistics: CountedListDTO<PlayerStatisticsDTO>
    private(set) var displayOrder: String
    
    init(team: TeamDTO, statistics: CountedListDTO<PlayerStatisticsDTO>, displayOrder: String) {
        self.team = team
        self.statistics = statistics
        self.displayOrder = displayOrder
    }
    
    func toEntity() -> PlayerBoxScoreEntity {
        return .init(
            team: team.toEntity(),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.compactMap{ $0.toEntity() }
            ),
            displayOrder: displayOrder
        )
    }
    
    static var defaultValue: PlayerBoxScoreDTO {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: ""
        )
    }
}

extension PlayerBoxScoreDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> PlayerBoxScoreDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let statistics: CountedListDTO<PlayerStatisticsDTO> = PlayerStatisticsDTO.toList(fromData: data.getArray(key: "statistics")) ?? .defaultValue
            
            return .init(
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                statistics: statistics,
                displayOrder: data.getString(key: "displayOrder")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<PlayerBoxScoreDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [PlayerBoxScoreDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [PlayerBoxScoreDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: PlayerBoxScoreDTO = .toObject(fromData: data) {
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


