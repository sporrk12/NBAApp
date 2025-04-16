//
//  LeagueDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

class LeagueDTO: DTO {
    private(set) var id: String
    private(set) var name: String
    private(set) var abbreviation: String
    private(set) var year: Int
    private(set) var season: String
    private(set) var teams: CountedListDTO<TeamDTO>
    
    init(id: String, name: String, abbreviation: String, year: Int, season: String, teams: CountedListDTO<TeamDTO>) {
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
                items: self.teams.items.compactMap { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: LeagueDTO {
        .init(
            id: "",
            name: "",
            abbreviation: "",
            year: 0,
            season: "",
            teams: .defaultValue
        )
    }
}

extension LeagueDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LeagueDTO? {
        if let data = data as? [String: Any] {
            let teams = TeamDTO.toList(fromData: data.getArray(key: "teams")) ?? .defaultValue
            
            return .init(
                id: data.getString(key: "id"),
                name: data.getString(key: "name"),
                abbreviation: data.getString(key: "abbreviation"),
                year: data.getInt(key: "year"),
                season: data.getDictionary(key: "season").getString(key: "displayName"),
                teams: teams
            )
        }
        return nil
    }

    static func toList(fromData data: Any?) -> CountedListDTO<LeagueDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LeagueDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LeagueDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LeagueDTO = .toObject(fromData: data) {
                    dtos.append(dto)
                }
            }
            return .init(
                count: data.getInt(key: "count"),
                items: dtos
            )
        }
        return nil
    }
}
