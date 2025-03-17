//
//  AthletesModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class AthletesModel: Model {
    private(set) var active: Bool
    private(set) var athlete: AthleteModel
    private(set) var starter: Bool
    private(set) var didNotPlay: Bool
    private(set) var reason: String
    private(set) var ejected: Bool
    private(set) var stats: CountedListModel<String>

    init(active: Bool, athlete: AthleteModel, starter: Bool, didNotPlay: Bool, reason: String, ejected: Bool, stats: CountedListModel<String>) {
        self.active = active
        self.athlete = athlete
        self.starter = starter
        self.didNotPlay = didNotPlay
        self.reason = reason
        self.ejected = ejected
        self.stats = stats
    }

    func toEntity() -> AthletesEntity {
        return .init(
            active: self.active,
            athlete: self.athlete.toEntity(),
            starter: self.starter,
            didNotPlay: self.didNotPlay,
            reason: self.reason,
            ejected: self.ejected,
            stats: .init(
                count: self.stats.count,
                items: self.stats.items
            )
        )
    }

    static var defaultValue: AthletesModel {
        .init(
            active: false,
            athlete: .defaultValue,
            starter: false,
            didNotPlay: false,
            reason: "",
            ejected: false,
            stats: .defaultValue
        )
    }

    static var shimmerValue: AthletesModel {
        .init(
            active: true,
            athlete: .shimmerValue,
            starter: true,
            didNotPlay: false,
            reason: "",
            ejected: false,
            stats: CountedListModel<String>(
                count: 5,
                items: ["10 PTS", "5 REB", "7 AST", "2 STL", "1 BLK"]
            )
        )
    }

    static var shimmerValues: CountedListModel<AthletesModel> {
        let athletes: [AthletesModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: athletes.count,
            items: athletes
        )
    }
}

extension AthletesModel: ParseableModel {
    static func toObject(fromData data: Any?) -> AthletesModel {
        if let data: AthletesEntity = data as? AthletesEntity {
            return .init(
                active: data.active,
                athlete: AthleteModel.toObject(fromData: data.athlete),
                starter: data.starter,
                didNotPlay: data.didNotPlay,
                reason: data.reason,
                ejected: data.ejected,
                stats: CountedListModel<String>(
                    count: data.stats.count,
                    items: data.stats.items
                )
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<AthletesModel> {
        if let data: CountedListEntity<AthletesEntity> = data as? CountedListEntity<AthletesEntity> {
            let models: [AthletesModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
