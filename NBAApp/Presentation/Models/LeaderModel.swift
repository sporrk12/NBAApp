//
//  LeaderModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class LeaderModel: Model {
    private(set) var name: String
    private(set) var displayName: String
    private(set) var shortDisplayName: String
    private(set) var abbreviation: String
    private(set) var leaderInfo: LeaderInfoModel
    
    init(name: String, displayName: String, shortDisplayName: String, abbreviation: String, leaderInfo: LeaderInfoModel) {
        self.name = name
        self.displayName = displayName
        self.shortDisplayName = shortDisplayName
        self.abbreviation = abbreviation
        self.leaderInfo = leaderInfo
    }
    
    func toEntity() -> LeaderEntity {
        return .init(
            name: self.name,
            displayName: self.displayName,
            shortDisplayName: self.shortDisplayName,
            abbreviation: self.abbreviation,
            leaderInfo: self.leaderInfo.toEntity()
        )
    }
    
    static var defaultValue: LeaderModel {
        .init(
            name: "",
            displayName: "",
            shortDisplayName: "",
            abbreviation: "",
            leaderInfo: .defaultValue
        )
    }
    
    static var shimmerValue: LeaderModel {
        .init(
            name: "Top Scorer",
            displayName: "Top Scorer",
            shortDisplayName: "TS",
            abbreviation: "PTS",
            leaderInfo: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<LeaderModel> {
        let leaderModels: [LeaderModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: leaderModels.count,
            items: leaderModels
        )
    }
}

extension LeaderModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LeaderModel {
        if let data: LeaderEntity = data as? LeaderEntity {
            return .init(
                name: data.name,
                displayName: data.displayName,
                shortDisplayName: data.shortDisplayName,
                abbreviation: data.abbreviation,
                leaderInfo: LeaderInfoModel.toObject(fromData: data.leaderInfo)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<LeaderModel> {
        if let data: CountedListEntity<LeaderEntity> = data as? CountedListEntity<LeaderEntity> {
            let models: [LeaderModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
