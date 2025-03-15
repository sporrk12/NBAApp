//
//  EventDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class EventDTO: DTO {
    private(set) var id: String
    private(set) var date: String
    private(set) var name: String
    private(set) var shortName: String
    private(set) var competitions: CountedListDTO<CompetitionDTO>
    private(set) var status: StatusDTO
    
    init(id: String, date: String, name: String, shortName: String, competitions: CountedListDTO<CompetitionDTO>, status: StatusDTO) {
        self.id = id
        self.date = date
        self.name = name
        self.shortName = shortName
        self.competitions = competitions
        self.status = status
    }
    
    func toEntity() -> EventEntity {
        return .init(
            id: self.id,
            date: self.date,
            name: self.name,
            shortName: self.shortName,
            competitions: .init(
                count: self.competitions.count,
                items: self.competitions.items.compactMap{ $0.toEntity() }
            ),
            status: .init(
                displayClock: self.status.displayClock,
                period: self.status.period,
                type: self.status.type.toEntity()
            )
        )
    }
    
    static var defaultValue: EventDTO {
        .init(
            id: "",
            date: "",
            name: "",
            shortName: "",
            competitions: .defaultValue,
            status: .defaultValue
        )
    }
}

extension EventDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> EventDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let competitions: CountedListDTO<CompetitionDTO> = CompetitionDTO.toList(fromData: data.getArray(key: "competitions")) ?? .defaultValue
            
            return .init(
                id: data.getString(key: "id"),
                date: data.getString(key: "date"),
                name: data.getString(key: "name"),
                shortName: data.getString(key: "shortName"),
                competitions: competitions,
                status: .toObject(fromData: data.getDictionary(key: "status")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<EventDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [EventDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [EventDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: EventDTO = .toObject(fromData: data) {
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
