//
//  SportDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 12/04/25.
//

import Foundation

class SportDTO: DTO {
    private(set) var id: String
    private(set) var name: String
    private(set) var leagues: CountedListDTO<LeagueDTO>
    
    init(id: String, name: String, leagues: CountedListDTO<LeagueDTO>) {
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
                items: self.leagues.items.compactMap { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: SportDTO {
        .init(
            id: "",
            name: "",
            leagues: .defaultValue
        )
    }
}

extension SportDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> SportDTO? {
        if let data = data as? [String: Any] {
            
            let leagues: CountedListDTO<LeagueDTO> = LeagueDTO.toList(fromData: data.getArray(key: "leagues")) ?? .defaultValue
            
            return .init(
                id: data.getString(key: "id"),
                name: data.getString(key: "name"),
                leagues: leagues
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<SportDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [SportDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [SportDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: SportDTO = .toObject(fromData: data) {
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
