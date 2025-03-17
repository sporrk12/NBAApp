//
//  LastFiveGameDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class LastFiveGameDTO: DTO {
    private(set) var displayOrder: Int
    private(set) var team: TeamDTO
    private(set) var events: CountedListDTO<GameEventDTO>
    
    init(displayOrder: Int, team: TeamDTO, events: CountedListDTO<GameEventDTO>) {
        self.displayOrder = displayOrder
        self.team = team
        self.events = events
    }
    
    func toEntity() -> LastFiveGameEntity {
        return .init(
            displayOrder: self.displayOrder,
            team: self.team.toEntity(),
            events: .init(
                count: self.events.count,
                items: self.events.items.compactMap{ $0.toEntity()}
            )
        )
    }
    
    static var defaultValue: LastFiveGameDTO {
        .init(
            displayOrder: 0,
            team: .defaultValue,
            events: .defaultValue
        )
    }
}

extension LastFiveGameDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LastFiveGameDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let events: CountedListDTO<GameEventDTO> = GameEventDTO.toList(fromData: data.getArray(key: "events")) ?? .defaultValue
            
            return .init(
                displayOrder: data.getInt(key: "displayOrder"),
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                events: events
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<LastFiveGameDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LastFiveGameDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LastFiveGameDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LastFiveGameDTO = .toObject(fromData: data) {
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


