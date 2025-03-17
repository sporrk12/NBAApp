//
//  InjuriesModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuriesModel: Model {
    private(set) var team: TeamModel
    private(set) var injuries: CountedListModel<InjuryModel>
    
    init(team: TeamModel, injuries: CountedListModel<InjuryModel>) {
        self.team = team
        self.injuries = injuries
    }
    
    func toEntity() -> InjuriesEntity {
        return .init(
            team: self.team.toEntity(),
            injuries: .init(
                count: self.injuries.count,
                items: self.injuries.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: InjuriesModel {
        .init(
            team: .defaultValue,
            injuries: .defaultValue
        )
    }
    
    static var shimmerValue: InjuriesModel {
        .init(
            team: .shimmerValue,
            injuries: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<InjuriesModel> {
        let typeModels: [InjuriesModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: typeModels.count,
            items: typeModels
        )
    }
}

extension InjuriesModel: ParseableModel {
    static func toObject(fromData data: Any?) -> InjuriesModel {
        if let data: InjuriesEntity = data as? InjuriesEntity {
            
            return .init(
                team: TeamModel.toObject(fromData: data.team),
                injuries: InjuryModel.toList(fromData: data.injuries)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<InjuriesModel> {
        if let data: CountedListEntity<InjuriesEntity> = data as? CountedListEntity<InjuriesEntity> {
            let models: [InjuriesModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}

