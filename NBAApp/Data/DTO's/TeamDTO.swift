//
//  TeamDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class TeamDTO: DTO {
    private(set) var id: String
    private(set) var location: String
    private(set) var name: String
    private(set) var abbreviation: String
    private(set) var displayName: String
    private(set) var shortDisplayName: String
    private(set) var color: String
    private(set) var alternateColor: String
    private(set) var isActive: Bool
    private(set) var logo: String
    
    init(id: String, location: String, name: String, abbreviation: String, displayName: String, shortDisplayName: String, color: String, alternateColor: String, isActive: Bool, logo: String) {
        self.id = id
        self.location = location
        self.name = name
        self.abbreviation = abbreviation
        self.displayName = displayName
        self.shortDisplayName = shortDisplayName
        self.color = color
        self.alternateColor = alternateColor
        self.isActive = isActive
        self.logo = logo
    }
    
    func toEntity() -> TeamEntity {
        return .init(
            id: self.id,
            location: self.location,
            name: self.name,
            abbreviation: self.abbreviation,
            displayName: self.displayName,
            shortDisplayName: self.shortDisplayName,
            color: self.color,
            alternateColor: self.alternateColor,
            isActive: self.isActive,
            logo: self.logo
        )
    }
    
    static var defaultValue: TeamDTO {
        .init(
            id: "",
            location: "",
            name: "",
            abbreviation: "",
            displayName: "",
            shortDisplayName: "",
            color: "",
            alternateColor: "",
            isActive: false,
            logo: ""
        )
    }
}

extension TeamDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> TeamDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                id: data.getString(key: "id"),
                location: data.getString(key: "location"),
                name: data.getString(key: "id"),
                abbreviation: data.getString(key: "abbreviation"),
                displayName: data.getString(key: "displayName"),
                shortDisplayName: data.getString(key: "shortDisplayName"),
                color: data.getString(key: "color"),
                alternateColor: data.getString(key: "alternateColor"),
                isActive: data.getBool(key: "isActive"),
                logo: data.getString(key: "logo")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<TeamDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [TeamDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [TeamDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: TeamDTO = .toObject(fromData: data) {
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

