//
//  TeamBoxScoreDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

class TeamBoxScoreDTO: DTO {
    private(set) var team: TeamDTO
    private(set) var statistics: CountedListDTO<StatisticsDTO>
    private(set) var displayOrder: String
    private(set) var homeAway: String
    
    init(team: TeamDTO, statistics: CountedListDTO<StatisticsDTO>, displayOrder: String, homeAway: String) {
        self.team = team
        self.statistics = statistics
        self.displayOrder = displayOrder
        self.homeAway = homeAway
    }
    
    func toEntity() -> TeamBoxScoreEntity {
        return .init(
            team: self.team.toEntity(),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.compactMap{ $0.toEntity() }
            ),
            displayOrder: self.displayOrder,
            homeAway: self.homeAway
        )
    }
    
    static var defaultValue: TeamBoxScoreDTO {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: "",
            homeAway: ""
        )
    }
}

extension TeamBoxScoreDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> TeamBoxScoreDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let statistics: CountedListDTO<StatisticsDTO> = StatisticsDTO.toList(fromData: data.getArray(key: "statistics")) ?? .defaultValue
            
            return .init(
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                statistics: statistics,
                displayOrder: data.getString(key: "displayOrder"),
                homeAway: data.getString(key: "homeAway")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<TeamBoxScoreDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [TeamBoxScoreDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [TeamBoxScoreDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: TeamBoxScoreDTO = .toObject(fromData: data) {
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

