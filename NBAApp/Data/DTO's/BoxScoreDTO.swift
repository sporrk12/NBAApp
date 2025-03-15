//
//  BoxScoreDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

class BoxScoreDTO: DTO {
    private(set) var teams: CountedListDTO<TeamBoxScoreDTO>
    private(set) var players : CountedListDTO<PlayerBoxScoreDTO>
    
    init(teams: CountedListDTO<TeamBoxScoreDTO>, players: CountedListDTO<PlayerBoxScoreDTO>) {
        self.teams = teams
        self.players = players
    }
    
    func toEntity() -> BoxScoreEntity {
        return .init(
            teams: .init(
                count: self.teams.count,
                items: self.teams.items.compactMap{ $0.toEntity() }
            ),
            players: .init(
                count: self.players.count,
                items: self.players.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: BoxScoreDTO {
        .init(
            teams: .defaultValue,
            players: .defaultValue
        )
    }
}

extension BoxScoreDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> BoxScoreDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let teams: CountedListDTO<TeamBoxScoreDTO> = TeamBoxScoreDTO.toList(fromData: data.getArray(key: "teams")) ?? .defaultValue
            
            let players: CountedListDTO<PlayerBoxScoreDTO> = PlayerBoxScoreDTO.toList(fromData: data.getArray(key: "players")) ?? .defaultValue
            
            
            return .init(
                teams: teams,
                players: players
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<BoxScoreDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [BoxScoreDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [BoxScoreDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: BoxScoreDTO = .toObject(fromData: data) {
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

