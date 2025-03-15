//
//  AthletesDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 14/03/25.
//

import Foundation

class AthletesDTO: DTO {
    private(set) var active: Bool
    private(set) var athlete: AthleteDTO
    private(set) var starter: Bool
    private(set) var didNotPlay: Bool
    private(set) var reason: String
    private(set) var ejected: Bool
    private(set) var stats: CountedListDTO<String>
    
    init(active: Bool, athlete: AthleteDTO, starter: Bool, didNotPlay: Bool, reason: String, ejected: Bool, stats: CountedListDTO<String>) {
        self.active = active
        self.athlete = athlete
        self.starter = starter
        self.didNotPlay = didNotPlay
        self.reason = reason
        self.ejected = ejected
        self.stats = stats
    }
    
    func toEntity() -> AthletesEntity {
        return .init(
            active: self.active,
            athlete: self.athlete.toEntity(),
            starter: self.starter,
            didNotPlay: self.didNotPlay,
            reason: self.reason,
            ejected: self.ejected,
            stats: .init(
                count: self.stats.count,
                items: self.stats.items
            )
        )
    }
    
    static var defaultValue: AthletesDTO {
        .init(
            active: false,
            athlete: .defaultValue,
            starter: false,
            didNotPlay: false,
            reason: "",
            ejected: false,
            stats: .defaultValue
        )
    }
}

extension AthletesDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> AthletesDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                active: data.getBool(key: "active"),
                athlete: .toObject(fromData: data.getDictionary(key: "athlete")) ?? .defaultValue,
                starter: data.getBool(key: "starter"),
                didNotPlay: data.getBool(key: "didNotPlay"),
                reason: data.getString(key: "reason"),
                ejected: data.getBool(key: "ejected"),
                stats: String.toList(fromData: data.getArray(key: "stats")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<AthletesDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [AthletesDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [AthletesDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: AthletesDTO = .toObject(fromData: data) {
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

