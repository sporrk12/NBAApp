//
//  PlayerBoxScoreModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class PlayerBoxScoreModel: Model {
    private(set) var team: TeamModel
    private(set) var statistics: CountedListModel<PlayerStatisticsModel>
    private(set) var displayOrder: String

    init(team: TeamModel, statistics: CountedListModel<PlayerStatisticsModel>, displayOrder: String) {
        self.team = team
        self.statistics = statistics
        self.displayOrder = displayOrder
    }

    func toEntity() -> PlayerBoxScoreEntity {
        return .init(
            team: self.team.toEntity(),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.compactMap { $0.toEntity() }
            ),
            displayOrder: self.displayOrder
        )
    }

    static var defaultValue: PlayerBoxScoreModel {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: ""
        )
    }

    static var shimmerValue: PlayerBoxScoreModel {
        .init(
            team: .shimmerValue,
            statistics: CountedListModel<PlayerStatisticsModel>(
                count: 5,
                items: (1...5).map { _ in .shimmerValue }
            ),
            displayOrder: "1"
        )
    }

    static var shimmerValues: CountedListModel<PlayerBoxScoreModel> {
        let playerBoxScores: [PlayerBoxScoreModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: playerBoxScores.count,
            items: playerBoxScores
        )
    }
}

extension PlayerBoxScoreModel: ParseableModel {
    static func toObject(fromData data: Any?) -> PlayerBoxScoreModel {
        if let data: PlayerBoxScoreEntity = data as? PlayerBoxScoreEntity {
            return .init(
                team: TeamModel.toObject(fromData: data.team),
                statistics: PlayerStatisticsModel.toList(fromData: data.statistics),
                displayOrder: data.displayOrder
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<PlayerBoxScoreModel> {
        if let data: CountedListEntity<PlayerBoxScoreEntity> = data as? CountedListEntity<PlayerBoxScoreEntity> {
            let models: [PlayerBoxScoreModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
