//
//  RecordModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class RecordModel: Model {
    private(set) var name: String
    private(set) var abbreviation: String
    private(set) var type: String
    private(set) var summary: String
    
    init(name: String, abbreviation: String, type: String, summary: String) {
        self.name = name
        self.abbreviation = abbreviation
        self.type = type
        self.summary = summary
    }
    
    func toEntity() -> RecordEntity {
        return .init(
            name: self.name,
            abbreviation: self.abbreviation,
            type: self.type,
            summary: self.summary
        )
    }
    
    static var defaultValue: RecordModel {
        .init(
            name: "",
            abbreviation: "",
            type: "",
            summary: ""
        )
    }
    
    static var shimmerValue: RecordModel {
        .init(
            name: "Wins",
            abbreviation: "W",
            type: "Regular Season",
            summary: "50-32"
        )
    }
    
    static var shimmerValues: CountedListModel<RecordModel> {
        let recordModels: [RecordModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: recordModels.count,
            items: recordModels
        )
    }
}

extension RecordModel: ParseableModel {
    static func toObject(fromData data: Any?) -> RecordModel {
        if let data: RecordEntity = data as? RecordEntity {
            return .init(
                name: data.name,
                abbreviation: data.abbreviation,
                type: data.type,
                summary: data.summary
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<RecordModel> {
        if let data: CountedListEntity<RecordEntity> = data as? CountedListEntity<RecordEntity> {
            let models: [RecordModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
