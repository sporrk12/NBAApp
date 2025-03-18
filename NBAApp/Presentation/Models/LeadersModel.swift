//
//  LeadersModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class LeadersModel: Model {
    private(set) var team: TeamModel
    private(set) var leaders: CountedListModel<LeaderModel>

    init(team: TeamModel, leaders: CountedListModel<LeaderModel>) {
        self.team = team
        self.leaders = leaders
    }

    func toEntity() -> LeadersEntity {
        return .init(
            team: self.team.toEntity(),
            leaders: .init(
                count: self.leaders.count,
                items: self.leaders.items.compactMap { $0.toEntity() }
            )
        )
    }

    static var defaultValue: LeadersModel {
        .init(
            team: .defaultValue,
            leaders: .defaultValue
        )
    }

    static var shimmerValue: LeadersModel {
        .init(
            team: .shimmerValue,
            leaders: .shimmerValue
        )
    }

    static var shimmerValues: CountedListModel<LeadersModel> {
        let leadersList: [LeadersModel] = (1...3).map { _ in .shimmerValue }
        return .init(
            count: leadersList.count,
            items: leadersList
        )
    }
}

extension LeadersModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LeadersModel {
        if let data: LeadersEntity = data as? LeadersEntity {
            return .init(
                team: TeamModel.toObject(fromData: data.team),
                leaders: LeaderModel.toList(fromData: data.leaders)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<LeadersModel> {
        if let data: CountedListEntity<LeadersEntity> = data as? CountedListEntity<LeadersEntity> {
            let models: [LeadersModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
