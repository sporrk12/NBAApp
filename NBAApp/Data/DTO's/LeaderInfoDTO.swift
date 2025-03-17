//
//  LeaderInfoDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class LeaderInfoDTO: DTO {
    private(set) var displayValue: String
    private(set) var athlete: AthleteDTO
    private(set) var team: TeamDTO
    private(set) var statistics: CountedListDTO<StatisticsDTO>
    
    init(displayValue: String, athlete: AthleteDTO, team: TeamDTO, statistics: CountedListDTO<StatisticsDTO>) {
        self.displayValue = displayValue
        self.athlete = athlete
        self.team = team
        self.statistics = statistics
    }

    func toEntity() -> LeaderInfoEntity {
        return .init(
            displayValue: self.displayValue,
            athlete: self.athlete.toEntity(),
            team: self.team.toEntity(),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: LeaderInfoDTO {
        .init(
            displayValue: "",
            athlete: .defaultValue,
            team: .defaultValue,
            statistics: .defaultValue
        )
    }
    
}

extension LeaderInfoDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LeaderInfoDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let statistics: CountedListDTO<StatisticsDTO> = StatisticsDTO.toList(fromData: data.getArray(key: "statistics")) ?? .defaultValue
            
            return .init(
                displayValue: data.getString(key: "displayValue"),
                athlete: .toObject(fromData: data.getDictionary(key: "athlete")) ?? .defaultValue,
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                statistics: statistics
            )
        }
        return nil
    }
    
    
    static func toList(fromData data: Any?) -> CountedListDTO<LeaderInfoDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LeaderInfoDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LeaderInfoDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LeaderInfoDTO = .toObject(fromData: data) {
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

