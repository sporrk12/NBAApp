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
    private(set) var logos: CountedListDTO<LogoDTO>
    private(set) var records: CountedListDTO<RecordDTO>
    private(set) var venue: VenueDTO
    private(set) var standingSummary: String
    private(set) var nextEvent: CountedListDTO<EventDTO>
    
    init(id: String, location: String, name: String, abbreviation: String, displayName: String, shortDisplayName: String, color: String, alternateColor: String, isActive: Bool, logo: String, logos: CountedListDTO<LogoDTO>, records: CountedListDTO<RecordDTO>, venue: VenueDTO, standingSummary: String, nextEvent: CountedListDTO<EventDTO>) {
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
        self.logos = logos
        self.records = records
        self.venue = venue
        self.standingSummary = standingSummary
        self.nextEvent = nextEvent
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
            logo: self.logo,
            logos: .init(
                count: self.logos.count,
                items: self.logos.items.compactMap { $0.toEntity() }
            ),
            records: .init(
                count: self.records.count,
                items: self.records.items.compactMap { $0.toEntity() }
            ),
            venue: self.venue.toEntity(),
            standingSummary: self.standingSummary,
            nextEvent: .init(
                count: self.nextEvent.count,
                items: self.nextEvent.items.compactMap { $0.toEntity() }
            )
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
            logo: "",
            logos: .defaultValue,
            records: .defaultValue,
            venue: .defaultValue,
            standingSummary: "",
            nextEvent: .defaultValue
        )
    }
}

extension TeamDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> TeamDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let logos: CountedListDTO<LogoDTO> = LogoDTO.toList(fromData: data.getArray(key: "logos")) ?? .defaultValue
            let records: CountedListDTO<RecordDTO> = RecordDTO.toList(fromData: data.getDictionary(key: "record")) ?? .defaultValue
            let nextEvent: CountedListDTO<EventDTO> = EventDTO.toList(fromData: data.getArray(key: "nextEvent")) ?? .defaultValue
            
            return .init(
                id: data.getString(key: "id"),
                location: data.getString(key: "location"),
                name: data.getString(key: "name"),
                abbreviation: data.getString(key: "abbreviation"),
                displayName: data.getString(key: "displayName"),
                shortDisplayName: data.getString(key: "shortDisplayName"),
                color: data.getString(key: "color"),
                alternateColor: data.getString(key: "alternateColor"),
                isActive: data.getBool(key: "isActive"),
                logo: data.getString(key: "logo"),
                logos: logos,
                records: records,
                venue: .toObject(fromData: data.getDictionary(key: "franchise").getDictionary(key: "venue")) ?? .defaultValue,
                standingSummary: data.getString(key: "standingSummary"),
                nextEvent: nextEvent
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<TeamDTO>? {
        if let data = data as? [[String: Any]] {
            
            let items: [TeamDTO] = data.compactMap { dict in
                if let nested = dict["team"] as? [String: Any] {
                    return toObject(fromData: nested)
                } else {
                    return toObject(fromData: dict)
                }
            }
            return .init(count: items.count, items: items)
        }
        
        if let data = data as? [String: Any] {
            
            let rawItems = data.getArray(key: "items")
            let dtos: [TeamDTO] = rawItems.compactMap { item in
                if let dict = item as? [String: Any] {
                    if let nested = dict["team"] as? [String: Any] {
                        return toObject(fromData: nested)
                    } else {
                        return toObject(fromData: dict)
                    }
                }
                return nil
            }
            return .init(
                count: data.getInt(key: "count"),
                items: dtos
            )
        }

        return nil
    }
}

