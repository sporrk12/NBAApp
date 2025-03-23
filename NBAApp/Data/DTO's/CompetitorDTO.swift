//
//  CompetitorDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class CompetitorDTO: DTO {
    private(set) var id: String
    private(set) var homeAway: String
    private(set) var winner: Bool
    private(set) var team: TeamDTO
    private(set) var score: String
    private(set) var lineScores: CountedListDTO<LineScoreDTO>
    private(set) var statistics: CountedListDTO<StatisticsDTO>
    private(set) var leaders: CountedListDTO<LeaderDTO>
    private(set) var records: CountedListDTO<RecordDTO>
    
    init(id: String, homeAway: String, winner: Bool, team: TeamDTO, score: String, lineScores: CountedListDTO<LineScoreDTO>, statistics: CountedListDTO<StatisticsDTO>, leaders: CountedListDTO<LeaderDTO>, records: CountedListDTO<RecordDTO>) {
        self.id = id
        self.homeAway = homeAway
        self.winner = winner
        self.team = team
        self.score = score
        self.lineScores = lineScores
        self.statistics = statistics
        self.leaders = leaders
        self.records = records
    }
    
    func toEntity() -> CompetitorEntity {
        return .init(
            id: self.id,
            homeAway: self.homeAway,
            winner: self.winner,
            team: self.team.toEntity(),
            score: self.score,
            lineScores: .init(
                count: self.lineScores.count,
                items: self.lineScores.items.compactMap{ $0.toEntity() }
            ),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.compactMap{ $0.toEntity() }
            ),
            leaders: .init(
                count: self.leaders.count,
                items: self.leaders.items.compactMap{ $0.toEntity() }
            ),
            records: .init(
                count: self.records.count,
                items: self.records.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: CompetitorDTO {
        .init(
            id: "",
            homeAway: "",
            winner: false,
            team: .defaultValue,
            score: "",
            lineScores: .defaultValue,
            statistics: .defaultValue,
            leaders: .defaultValue,
            records: .defaultValue
        )
    }
}

extension CompetitorDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> CompetitorDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let lineScores: CountedListDTO<LineScoreDTO> = LineScoreDTO.toList(fromData: data.getArray(key: "linescores")) ?? .defaultValue
            
            let statistics: CountedListDTO<StatisticsDTO> = StatisticsDTO.toList(fromData: data.getArray(key: "statistics")) ?? .defaultValue
            
            let leaders: CountedListDTO<LeaderDTO> = LeaderDTO.toList(fromData: data.getArray(key: "leaders")) ?? .defaultValue
            
            let records: CountedListDTO<RecordDTO> = RecordDTO.toList(fromData: data.getArray(keys: ["records", "record"])) ?? .defaultValue
            
            return .init(
                id: data.getString(key: "id"),
                homeAway: data.getString(key: "homeAway"),
                winner: data.getBool(key: "winner"),
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                score: data.getString(key: "score"),
                lineScores: lineScores,
                statistics: statistics,
                leaders: leaders,
                records: records
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<CompetitorDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [CompetitorDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [CompetitorDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: CompetitorDTO = .toObject(fromData: data) {
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
