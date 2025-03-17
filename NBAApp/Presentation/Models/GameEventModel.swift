//
//  GameEventModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class GameEventModel: Model {
    private(set) var id: String
    private(set) var gameDate: String
    private(set) var score: String
    private(set) var homeTeamId: String
    private(set) var awayTeamId: String
    private(set) var homeTeamScore: String
    private(set) var awayTeamScore: String
    private(set) var gameResult: String
    private(set) var opponent: TeamModel

    init(id: String, gameDate: String, score: String, homeTeamId: String, awayTeamId: String, homeTeamScore: String, awayTeamScore: String, gameResult: String, opponent: TeamModel) {
        self.id = id
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

    static var defaultValue: GameEventModel {
        return .init(
            id: "",
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

    static var shimmerValue: GameEventModel {
        return .init(
            id: "12345",
            gameDate: "2025-03-15",
            score: "100 - 98",
            homeTeamId: "LAL",
            awayTeamId: "BOS",
            homeTeamScore: "100",
            awayTeamScore: "98",
            gameResult: "W",
            opponent: .shimmerValue
        )
    }

    static var shimmerValues: CountedListModel<GameEventModel> {
        let gameEvents: [GameEventModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: gameEvents.count,
            items: gameEvents
        )
    }
}

extension GameEventModel: ParseableModel {
    static func toObject(fromData data: Any?) -> GameEventModel {
        if let data: GameEventEntity = data as? GameEventEntity {
            return .init(
                id: data.id,
                gameDate: data.gameDate,
                score: data.score,
                homeTeamId: data.homeTeamId,
                awayTeamId: data.awayTeamId,
                homeTeamScore: data.homeTeamScore,
                awayTeamScore: data.awayTeamScore,
                gameResult: data.gameResult,
                opponent: TeamModel.toObject(fromData: data.opponent)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<GameEventModel> {
        if let data: CountedListEntity<GameEventEntity> = data as? CountedListEntity<GameEventEntity> {
            let models: [GameEventModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
