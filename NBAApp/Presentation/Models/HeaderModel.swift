//
//  HeaderModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

import Foundation

class HeaderModel: Model {
    private(set) var id: String
    private(set) var timeValid: Bool
    private(set) var competitions: CountedListModel<CompetitionModel>
    
    init(id: String, timeValid: Bool, competitions: CountedListModel<CompetitionModel>) {
        self.id = id
        self.timeValid = timeValid
        self.competitions = competitions
    }
    
    func toEntity() -> HeaderEntity {
        return  .init(
            id: self.id,
            timeValid: self.timeValid,
            competititons: .init(
                count: self.competitions.count,
                items: self.competitions.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: HeaderModel {
        .init(
            id: "",
            timeValid: false,
            competitions: .defaultValue
        )
    }
    
    static var shimmerValue: HeaderModel {
        .init(
            id: "1232",
            timeValid: false,
            competitions: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<HeaderModel> {
        let headerModels: [HeaderModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: headerModels.count,
            items: headerModels
        )
    }
}

extension HeaderModel: ParseableModel {
    static func toObject(fromData data: Any?) -> HeaderModel {
        if let data: HeaderEntity = data as? HeaderEntity {
            return .init(
                id: data.id,
                timeValid: data.timeValid,
                competitions: CompetitionModel.toList(fromData: data.competititons)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<HeaderModel> {
        if let data: CountedListEntity<HeaderEntity> = data as? CountedListEntity<HeaderEntity> {
            let models: [HeaderModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}

