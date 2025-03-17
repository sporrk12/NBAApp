//
//  TeamBoxScoreModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class TeamBoxScoreModel: Model {
    private(set) var team: TeamModel
    private(set) var statistics: CountedListModel<StatisticsModel>
    private(set) var displayOrder: String
    private(set) var homeAway: String

    init(team: TeamModel, statistics: CountedListModel<StatisticsModel>, displayOrder: String, homeAway: String) {
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
                items: self.statistics.items.compactMap { $0.toEntity() }
            ),
            displayOrder: self.displayOrder,
            homeAway: self.homeAway
        )
    }

    static var defaultValue: TeamBoxScoreModel {
        .init(
            team: .defaultValue,
            statistics: .defaultValue,
            displayOrder: "",
            homeAway: ""
        )
    }

    static var shimmerValue: TeamBoxScoreModel {
        .init(
            team: .shimmerValue,
            statistics: CountedListModel<StatisticsModel>(
                count: 5,
                items: (1...5).map { _ in .shimmerValue }
            ),
            displayOrder: "1",
            homeAway: "home"
        )
    }

    static var shimmerValues: CountedListModel<TeamBoxScoreModel> {
        let teamBoxScores: [TeamBoxScoreModel] = (1...2).map { _ in .shimmerValue }
        return .init(
            count: teamBoxScores.count,
            items: teamBoxScores
        )
    }
}

extension TeamBoxScoreModel: ParseableModel {
    static func toObject(fromData data: Any?) -> TeamBoxScoreModel {
        if let data: TeamBoxScoreEntity = data as? TeamBoxScoreEntity {
            return .init(
                team: TeamModel.toObject(fromData: data.team),
                statistics: StatisticsModel.toList(fromData: data.statistics),
                displayOrder: data.displayOrder,
                homeAway: data.homeAway
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<TeamBoxScoreModel> {
        if let data: CountedListEntity<TeamBoxScoreEntity> = data as? CountedListEntity<TeamBoxScoreEntity> {
            let models: [TeamBoxScoreModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
