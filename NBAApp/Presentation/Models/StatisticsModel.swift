//
//  StatisticsModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class StatisticsModel: Model {
    private(set) var name: String
    private(set) var displayName: String
    private(set) var abbreviation: String
    private(set) var displayValue: String
    private(set) var label: String

    init(name: String, displayName: String, abbreviation: String, displayValue: String, label: String) {
        self.name = name
        self.displayName = displayName
        self.abbreviation = abbreviation
        self.displayValue = displayValue
        self.label = label
    }
    
    func toEntity() -> StatisticsEntity {
        return .init(
            name: self.name,
            displayName: self.displayName,
            abbreviation: self.abbreviation,
            displayValue: self.displayValue,
            label: self.label
        )
    }
    
    static var defaultValue: StatisticsModel {
        .init(
            name: "",
            displayName: "",
            abbreviation: "",
            displayValue: "",
            label: ""
        )
    }
    
    static var shimmerValue: StatisticsModel {
        .init(
            name: "Points",
            displayName: "Points",
            abbreviation: "PTS",
            displayValue: "25",
            label: "PTS"
        )
    }
    
    static var shimmerValues: CountedListModel<StatisticsModel> {
        let statisticsModels: [StatisticsModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: statisticsModels.count,
            items: statisticsModels
        )
    }
}

extension StatisticsModel: ParseableModel {
    static func toObject(fromData data: Any?) -> StatisticsModel {
        if let data: StatisticsEntity = data as? StatisticsEntity {
            return .init(
                name: data.name,
                displayName: data.displayName,
                abbreviation: data.abbreviation,
                displayValue: data.displayValue,
                label: data.label
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<StatisticsModel> {
        if let data: CountedListEntity<StatisticsEntity> = data as? CountedListEntity<StatisticsEntity> {
            let models: [StatisticsModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
