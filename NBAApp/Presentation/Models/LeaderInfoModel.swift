//
//  LeaderInfoModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class LeaderInfoModel: Model {
    private(set) var displayValue: String
    private(set) var athlete: AthleteModel
    private(set) var team: TeamModel
    
    init(displayValue: String, athlete: AthleteModel, team: TeamModel) {
        self.displayValue = displayValue
        self.athlete = athlete
        self.team = team
    }
    
    func toEntity() -> LeaderInfoEntity {
        return .init(
            displayValue: self.displayValue,
            athlete: self.athlete.toEntity(),
            team: self.team.toEntity()
        )
    }
    
    static var defaultValue: LeaderInfoModel {
        .init(
            displayValue: "",
            athlete: .defaultValue,
            team: .defaultValue
        )
    }
    
    static var shimmerValue: LeaderInfoModel {
        .init(
            displayValue: "30 PTS",
            athlete: .shimmerValue,
            team: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<LeaderInfoModel> {
        let leaderInfoModels: [LeaderInfoModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: leaderInfoModels.count,
            items: leaderInfoModels
        )
    }
}

extension LeaderInfoModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LeaderInfoModel {
        if let data: LeaderInfoEntity = data as? LeaderInfoEntity {
            return .init(
                displayValue: data.displayValue,
                athlete: AthleteModel.toObject(fromData: data.athlete),
                team: TeamModel.toObject(fromData: data.team)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<LeaderInfoModel> {
        if let data: CountedListEntity<LeaderInfoEntity> = data as? CountedListEntity<LeaderInfoEntity> {
            let models: [LeaderInfoModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
