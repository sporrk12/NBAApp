//
//  LeagueModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

class LeagueModel: Model {
    private(set) var id: String
    private(set) var name: String
    private(set) var abbreviation: String
    private(set) var year: Int
    private(set) var season: String
    private(set) var teams: CountedListModel<TeamModel>
    
    init(id: String, name: String, abbreviation: String, year: Int, season: String, teams: CountedListModel<TeamModel>) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.year = year
        self.season = season
        self.teams = teams
    }
    
    func toEntity() -> LeagueEntity {
        return .init(
            id: self.id,
            name: self.name,
            abbreviation: self.abbreviation,
            year: self.year,
            season: self.season,
            teams: .init(
                count: self.teams.count,
                items: self.teams.items.map { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: LeagueModel {
        .init(
            id: "",
            name: "",
            abbreviation: "",
            year: 0,
            season: "",
            teams: .defaultValue
        )
    }
    
    static var shimmerValue: LeagueModel {
        .init(
            id: "000",
            name: "League Name",
            abbreviation: "LGA",
            year: 2025,
            season: "Regular",
            teams: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<LeagueModel> {
        let leagues = (1...3).map { _ in shimmerValue }
        return .init(count: leagues.count, items: leagues)
    }
}

extension LeagueModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LeagueModel {
        guard let entity = data as? LeagueEntity else {
            return .defaultValue
        }
        
        return .init(
            id: entity.id,
            name: entity.name,
            abbreviation: entity.abbreviation,
            year: entity.year,
            season: entity.season,
            teams: TeamModel.toList(fromData: entity.teams)
        )
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<LeagueModel> {
        guard let entityList = data as? CountedListEntity<LeagueEntity> else {
            return .defaultValue
        }
        
        let models = entityList.items.map { toObject(fromData: $0) }
        return .init(count: entityList.count, items: models)
    }
}
