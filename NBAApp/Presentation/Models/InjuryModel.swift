//
//  InjuryModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuryModel: Model {
    private(set) var status: String
    private(set) var date: String
    private(set) var athlete: AthleteModel
    private(set) var type: TypeModel
    private(set) var details: InjuryDetailModel
    
    init(status: String, date: String, athlete: AthleteModel, type: TypeModel, details: InjuryDetailModel) {
        self.status = status
        self.date = date
        self.athlete = athlete
        self.type = type
        self.details = details
    }
    
    func toEntity() -> InjuryEntity {
        return .init(
            status: self.status,
            date: self.date,
            athlete: self.athlete.toEntity(),
            type: self.type.toEntity(),
            details: self.details.toEntity()
        )
    }
    
    static var defaultValue: InjuryModel {
        return .init(
            status: "",
            date: "",
            athlete: .defaultValue,
            type: .defaultValue,
            details: .defaultValue
        )
    }
    
    static var shimmerValue: InjuryModel {
        .init(
            status: "Lorem",
            date: "2021-01-01",
            athlete: .shimmerValue,
            type: .shimmerValue,
            details: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<InjuryModel> {
        let leaderModels: [InjuryModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: leaderModels.count,
            items: leaderModels
        )
    }
}

extension InjuryModel: ParseableModel {
    static func toObject(fromData data: Any?) -> InjuryModel {
        if let data: InjuryEntity = data as? InjuryEntity {
            
            return .init(
                status: data.status,
                date: data.date,
                athlete: AthleteModel.toObject(fromData: data.athlete),
                type: TypeModel.toObject(fromData: data.type),
                details: InjuryDetailModel.toObject(fromData: data.details)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<InjuryModel> {
        if let data: CountedListEntity<InjuryEntity> = data as? CountedListEntity<InjuryEntity> {
            let models: [InjuryModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
