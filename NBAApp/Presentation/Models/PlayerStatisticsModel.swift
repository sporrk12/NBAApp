//
//  PlayerStatisticsModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class PlayerStatisticsModel: Model {
    private(set) var names: CountedListModel<String>
    private(set) var keys: CountedListModel<String>
    private(set) var labels: CountedListModel<String>
    private(set) var descriptions: CountedListModel<String>
    private(set) var athletes: CountedListModel<AthletesModel>
    private(set) var totals: CountedListModel<String>

    init(names: CountedListModel<String>, keys: CountedListModel<String>, labels: CountedListModel<String>, descriptions: CountedListModel<String>, athletes: CountedListModel<AthletesModel>, totals: CountedListModel<String>) {
        self.names = names
        self.keys = keys
        self.labels = labels
        self.descriptions = descriptions
        self.athletes = athletes
        self.totals = totals
    }

    func toEntity() -> PlayerStatisticsEntity {
        return .init(
            names: .init(count: self.names.count, items: self.names.items),
            keys: .init(count: self.keys.count, items: self.keys.items),
            labels: .init(count: self.labels.count, items: self.labels.items),
            descriptions: .init(count: self.descriptions.count, items: self.descriptions.items),
            athletes: .init(count: self.athletes.count, items: self.athletes.items.compactMap { $0.toEntity() }),
            totals: .init(count: self.totals.count, items: self.totals.items)
        )
    }

    static var defaultValue: PlayerStatisticsModel {
        .init(
            names: .defaultValue,
            keys: .defaultValue,
            labels: .defaultValue,
            descriptions: .defaultValue,
            athletes: .defaultValue,
            totals: .defaultValue
        )
    }

    static var shimmerValue: PlayerStatisticsModel {
        .init(
            names: CountedListModel<String>(count: 3, items: ["PTS", "REB", "AST"]),
            keys: CountedListModel<String>(count: 3, items: ["points", "rebounds", "assists"]),
            labels: CountedListModel<String>(count: 3, items: ["Puntos", "Rebotes", "Asistencias"]),
            descriptions: CountedListModel<String>(count: 3, items: ["Total de puntos", "Total de rebotes", "Total de asistencias"]),
            athletes: CountedListModel<AthletesModel>(
                count: 5,
                items: (1...5).map { _ in .shimmerValue }
            ),
            totals: CountedListModel<String>(count: 3, items: ["100", "50", "20"])
        )
    }

    static var shimmerValues: CountedListModel<PlayerStatisticsModel> {
        let playerStatistics: [PlayerStatisticsModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: playerStatistics.count,
            items: playerStatistics
        )
    }
}

extension PlayerStatisticsModel: ParseableModel {
    static func toObject(fromData data: Any?) -> PlayerStatisticsModel {
        if let data: PlayerStatisticsEntity = data as? PlayerStatisticsEntity {
            return .init(
                names: CountedListModel<String>(count: data.names.count, items: data.names.items),
                keys: CountedListModel<String>(count: data.keys.count, items: data.keys.items),
                labels: CountedListModel<String>(count: data.labels.count, items: data.labels.items),
                descriptions: CountedListModel<String>(count: data.descriptions.count, items: data.descriptions.items),
                athletes: AthletesModel.toList(fromData: data.athletes),
                totals: CountedListModel<String>(count: data.totals.count, items: data.totals.items)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<PlayerStatisticsModel> {
        if let data: CountedListEntity<PlayerStatisticsEntity> = data as? CountedListEntity<PlayerStatisticsEntity> {
            let models: [PlayerStatisticsModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
