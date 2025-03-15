//
//  LineScoreModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class LineScoreModel: Model {
    private(set) var value: Double
    
    init(value: Double) {
        self.value = value
    }
    
    func toEntity() -> LineScoreEntity {
        return .init(value: self.value)
    }
    
    static var defaultValue: LineScoreModel {
        .init(value: 0.0)
    }
    
    static var shimmerValue: LineScoreModel {
        .init(value: 10.0)
    }
    
    static var shimmerValues: CountedListModel<LineScoreModel> {
        let lineScoreModels: [LineScoreModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: lineScoreModels.count,
            items: lineScoreModels
        )
    }
}

extension LineScoreModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LineScoreModel {
        if let data: LineScoreEntity = data as? LineScoreEntity {
            return .init(value: data.value)
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<LineScoreModel> {
        if let data: CountedListEntity<LineScoreEntity> = data as? CountedListEntity<LineScoreEntity> {
            let models: [LineScoreModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
