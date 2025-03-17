//
//  InjuryDetailModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuryDetailModel: Model {
    private(set) var type: String
    private(set) var location: String
    private(set) var detail: String
    private(set) var side: String
    private(set) var returnDate: String
    
    init(type: String, location: String, detail: String, side: String, returnDate: String) {
        self.type = type
        self.location = location
        self.detail = detail
        self.side = side
        self.returnDate = returnDate
    }
    
    func toEntity() -> InjuryDetailEntity {
        return .init(
            type: self.type,
            location: self.location,
            detail: self.detail,
            side: self.side,
            returnDate: self.returnDate
        )
    }
    
    static var defaultValue: InjuryDetailModel {
        .init(
            type: "",
            location: "",
            detail: "",
            side: "",
            returnDate: ""
        )
    }
    
    static var shimmerValue: InjuryDetailModel {
        .init(
            type: "Injury",
            location: "Leg",
            detail: "Sprain",
            side: "Right",
            returnDate: "2025-03-15"
        )
    }
    
    static var shimmerValues: CountedListModel<InjuryDetailModel> {
        let leaderModels: [InjuryDetailModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: leaderModels.count,
            items: leaderModels
        )
    }
}

extension InjuryDetailModel: ParseableModel {
    static func toObject(fromData data: Any?) -> InjuryDetailModel {
        if let data: InjuryDetailEntity = data as? InjuryDetailEntity {
            return .init(
                type: data.type,
                location: data.location,
                detail: data.detail,
                side: data.side,
                returnDate: data.returnDate
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<InjuryDetailModel> {
        if let data: CountedListEntity<InjuryDetailEntity> = data as? CountedListEntity<InjuryDetailEntity> {
            let models: [InjuryDetailModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
