//
//  BoxScoreModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class BoxScoreModel: Model {
    private(set) var teams: CountedListModel<TeamBoxScoreModel>
    private(set) var players: CountedListModel<PlayerBoxScoreModel>

    init(teams: CountedListModel<TeamBoxScoreModel>, players: CountedListModel<PlayerBoxScoreModel>) {
        self.teams = teams
        self.players = players
    }

    func toEntity() -> BoxScoreEntity {
        return .init(
            teams: .init(
                count: self.teams.count,
                items: self.teams.items.compactMap { $0.toEntity() }
            ),
            players: .init(
                count: self.players.count,
                items: self.players.items.compactMap { $0.toEntity() }
            )
        )
    }

    static var defaultValue: BoxScoreModel {
        .init(
            teams: .defaultValue,
            players: .defaultValue
        )
    }

    static var shimmerValue: BoxScoreModel {
        .init(
            teams: CountedListModel<TeamBoxScoreModel>(
                count: 2,
                items: (1...2).map { _ in .shimmerValue }
            ),
            players: CountedListModel<PlayerBoxScoreModel>(
                count: 10,
                items: (1...10).map { _ in .shimmerValue }
            )
        )
    }

    static var shimmerValues: CountedListModel<BoxScoreModel> {
        let boxScores: [BoxScoreModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: boxScores.count,
            items: boxScores
        )
    }
}

extension BoxScoreModel: ParseableModel {
    static func toObject(fromData data: Any?) -> BoxScoreModel {
        if let data: BoxScoreEntity = data as? BoxScoreEntity {
            return .init(
                teams: TeamBoxScoreModel.toList(fromData: data.teams),
                players: PlayerBoxScoreModel.toList(fromData: data.players)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<BoxScoreModel> {
        if let data: CountedListEntity<BoxScoreEntity> = data as? CountedListEntity<BoxScoreEntity> {
            let models: [BoxScoreModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
