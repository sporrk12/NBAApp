//
//  GameEventDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class GameEventDTO: DTO {
    private(set) var id: String
    private(set) var atVs: String
    private(set) var gameDate: String
    private(set) var score: String
    private(set) var homeTeamId: String
    private(set) var awayTeamId: String
    private(set) var homeTeamScore: String
    private(set) var awayTeamScore: String
    private(set) var gameResult: String
    private(set) var opponent: TeamDTO
    
    init(id: String, atVs: String, gameDate: String, score: String, homeTeamId: String, awayTeamId: String, homeTeamScore: String, awayTeamScore: String, gameResult: String, opponent: TeamDTO) {
        self.id = id
        self.atVs = atVs
        self.gameDate = gameDate
        self.score = score
        self.homeTeamId = homeTeamId
        self.awayTeamId = awayTeamId
        self.homeTeamScore = homeTeamScore
        self.awayTeamScore = awayTeamScore
        self.gameResult = gameResult
        self.opponent = opponent
    }
    
    func toEntity() -> GameEventEntity {
        return .init(
            id: self.id,
            atVs: self.atVs,
            gameDate: self.gameDate,
            score: self.score,
            homeTeamId: self.homeTeamId,
            awayTeamId: self.awayTeamId,
            homeTeamScore: self.homeTeamScore,
            awayTeamScore: self.awayTeamScore,
            gameResult: self.gameResult,
            opponent: self.opponent.toEntity()
        )
    }
    
    static var defaultValue: GameEventDTO {
        return .init(
            id: "",
            atVs: "",
            gameDate: "",
            score: "",
            homeTeamId: "",
            awayTeamId: "",
            homeTeamScore: "",
            awayTeamScore: "",
            gameResult: "",
            opponent: .defaultValue
        )
    }
}

extension GameEventDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> GameEventDTO? {
        if let data: [String: Any] = data as? [String: Any] {
    
            return .init(
                id: data.getString(key: "id"),
                atVs: data.getString(key: "atVs"),
                gameDate: data.getString(key: "gameDate"),
                score: data.getString(key: "score"),
                homeTeamId: data.getString(key: "homeTeamId"),
                awayTeamId: data.getString(key: "awayTeamId"),
                homeTeamScore: data.getString(key: "homeTeamScore"),
                awayTeamScore: data.getString(key: "awayTeamScore"),
                gameResult: data.getString(key: "gameResult"),
                opponent: .toObject(fromData: data.getDictionary(key: "opponent")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<GameEventDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [GameEventDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [GameEventDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: GameEventDTO = .toObject(fromData: data) {
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



