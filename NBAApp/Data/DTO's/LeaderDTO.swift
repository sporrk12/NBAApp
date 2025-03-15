//
//  LeaderDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class LeaderDTO: DTO {
    private(set) var name: String
    private(set) var displayName: String
    private(set) var shortDisplayName: String
    private(set) var abbreviation: String
    private(set) var leaderInfo: LeaderInfoDTO
    
    
    init(name: String, displayName: String, shortDisplayName: String, abbreviation: String, leaderInfo: LeaderInfoDTO) {
        self.name = name
        self.displayName = displayName
        self.shortDisplayName = shortDisplayName
        self.abbreviation = abbreviation
        self.leaderInfo = leaderInfo
    }
    
    func toEntity() -> LeaderEntity {
        return .init(
            name: self.name,
            displayName: self.displayName,
            shortDisplayName: self.shortDisplayName,
            abbreviation: self.abbreviation,
            leaderInfo: self.leaderInfo.toEntity()
        )
    }
    
    static var defaultValue: LeaderDTO {
        .init(
            name: "",
            displayName: "",
            shortDisplayName: "",
            abbreviation: "",
            leaderInfo: .defaultValue
        )
    }
}

extension LeaderDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LeaderDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                name: data.getString(key: "name"),
                displayName: data.getString(key: "displayName"),
                shortDisplayName: data.getString(key: "shortDisplayName"),
                abbreviation: data.getString(key: "abbreviation"),
                leaderInfo: .toObject(fromData: data.getDictionary(key: "leaders")) ?? .defaultValue
            )
        }
        return nil
    }
    
    
    static func toList(fromData data: Any?) -> CountedListDTO<LeaderDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LeaderDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LeaderDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LeaderDTO = .toObject(fromData: data) {
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
