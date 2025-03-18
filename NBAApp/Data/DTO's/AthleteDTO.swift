//
//  AthleteDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class AthleteDTO: DTO {
    private(set) var id: String
    private(set) var fullName: String
    private(set) var displayName: String
    private(set) var shortName: String
    private(set) var headshot: String
    private(set) var jersey: String
    private(set) var position: String
    private(set) var team: TeamDTO
    private(set) var active: Bool
    
    init(id: String, fullName: String, displayName: String, shortName: String, headshot: String, jersey: String, position: String, team: TeamDTO, active: Bool) {
        self.id = id
        self.fullName = fullName
        self.displayName = displayName
        self.shortName = shortName
        self.headshot = headshot
        self.jersey = jersey
        self.position = position
        self.team = team
        self.active = active
    }
    
    func toEntity() -> AthleteEntity {
        return .init(
            id: self.id,
            fullName: self.fullName,
            displayName: self.displayName,
            shortName: self.shortName,
            headshot: self.headshot,
            jersey: self.jersey,
            position: self.position,
            team: self.team.toEntity(),
            active: self.active
        )
    }
    
    static var defaultValue: AthleteDTO {
        .init(
            id: "",
            fullName: "",
            displayName: "",
            shortName: "",
            headshot: "",
            jersey: "",
            position: "",
            team: .defaultValue,
            active: false
        )
    }
}

extension AthleteDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> AthleteDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                id: data.getString(key: "id"),
                fullName: data.getString(key: "fullName"),
                displayName: data.getString(key: "displayName"),
                shortName: data.getString(key: "shortName"),
                headshot: data.getDictionary(key: "headshot").getString(key: "href"),
                jersey: data.getString(key: "jersey"),
                position: data.getDictionary(key: "position").getString(key: "abbreviation"),
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                active: data.getBool(key: "active")
            )
        }
        return nil
    }
    
    
    static func toList(fromData data: Any?) -> CountedListDTO<AthleteDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [AthleteDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [AthleteDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: AthleteDTO = .toObject(fromData: data) {
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


