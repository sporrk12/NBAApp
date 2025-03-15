//
//  StatusModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class StatusModel: Model {
    private(set) var displayClock: String
    private(set) var period: Int
    private(set) var type: TypeModel
    
    init(displayClock: String, period: Int, type: TypeModel) {
        self.displayClock = displayClock
        self.period = period
        self.type = type
    }
    
    func toEntity() -> StatusEntity {
        return .init(
            displayClock: self.displayClock,
            period: self.period,
            type: self.type.toEntity()
        )
    }
    
    static var defaultValue: StatusModel {
        .init(
            displayClock: "",
            period: 0,
            type: .defaultValue
        )
    }
    
    static var shimmerValue: StatusModel {
        .init(
            displayClock: "00:00",
            period: 1,
            type: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<StatusModel> {
        let statusModels: [StatusModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: statusModels.count,
            items: statusModels
        )
    }
}

extension StatusModel: ParseableModel {
    static func toObject(fromData data: Any?) -> StatusModel {
        if let data: StatusEntity = data as? StatusEntity {
            return .init(
                displayClock: data.displayClock,
                period: data.period,
                type: TypeModel.toObject(fromData: data.type)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<StatusModel> {
        if let data: CountedListEntity<StatusEntity> = data as? CountedListEntity<StatusEntity> {
            let models: [StatusModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
