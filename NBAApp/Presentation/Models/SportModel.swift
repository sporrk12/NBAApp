//
//  SportModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

class SportModel: Model {
    private(set) var id: String
    private(set) var name: String
    private(set) var leagues: CountedListModel<LeagueModel>
    
    init(id: String, name: String, leagues: CountedListModel<LeagueModel>) {
        self.id = id
        self.name = name
        self.leagues = leagues
    }
    
    func toEntity() -> SportEntity {
        return .init(
            id: self.id,
            name: self.name,
            leagues: .init(
                count: self.leagues.count,
                items: self.leagues.items.map { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: SportModel {
        .init(
            id: "",
            name: "",
            leagues: .defaultValue
        )
    }
    
    static var shimmerValue: SportModel {
        .init(
            id: "0000",
            name: "Loading...",
            leagues: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<SportModel> {
        let sports = (1...5).map { _ in shimmerValue }
        return .init(count: sports.count, items: sports)
    }
}

extension SportModel: ParseableModel {
    static func toObject(fromData data: Any?) -> SportModel {
        guard let entity = data as? SportEntity else {
            return .defaultValue
        }
        
        return .init(
            id: entity.id,
            name: entity.name,
            leagues: LeagueModel.toList(fromData: entity.leagues)
        )
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<SportModel> {
        guard let entityList = data as? CountedListEntity<SportEntity> else {
            return .defaultValue
        }
        
        let models = entityList.items.map { toObject(fromData: $0) }
        return .init(count: entityList.count, items: models)
    }
}
