//
//  StatModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/04/25.
//

import Foundation

class StatModel: Model {
    private(set) var name: String
    private(set) var value: String

    init(name: String, value: String) {
        self.name = name
        self.value = value
    }

    func toEntity() -> StatEntity {
        return .init(
            name: self.name,
            value: self.value
        )
    }

    static var defaultValue: StatModel {
        .init(name: "", value: "")
    }

    static var shimmerValue: StatModel {
        .init(name: "PTS", value: "--")
    }

    static var shimmerValues: CountedListModel<StatModel> {
        let values = (1...5).map { _ in shimmerValue }
        return .init(count: values.count, items: values)
    }
}

extension StatModel: ParseableModel {
    static func toObject(fromData data: Any?) -> StatModel {
        guard let entity = data as? StatEntity else {
            return .defaultValue
        }
        return .init(name: entity.name, value: entity.value)
    }

    static func toList(fromData data: Any?) -> CountedListModel<StatModel> {
        guard let entityList = data as? CountedListEntity<StatEntity> else {
            return .defaultValue
        }

        let models = entityList.items.map { toObject(fromData: $0) }
        return .init(count: entityList.count, items: models)
    }
}
