//
//  TeamModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class TeamModel: Model {
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
    private(set) var logos: CountedListModel<LogoModel>
    private(set) var records: CountedListModel<RecordModel>
    private(set) var venue: VenueModel
    private(set) var standingSummary: String
    private(set) var nextEvent: CountedListModel<EventModel>
    
    init(id: String, location: String, name: String, abbreviation: String, displayName: String, shortDisplayName: String, color: String, alternateColor: String, isActive: Bool, logo: String, logos: CountedListModel<LogoModel>, records: CountedListModel<RecordModel>, venue: VenueModel, standingSummary: String, nextEvent: CountedListModel<EventModel>) {
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
    
    static var defaultValue: TeamModel {
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
    
    static var shimmerValue: TeamModel {
        .init(
            id: "0000",
            location: "Sample City",
            name: "Sample Team",
            abbreviation: "ST",
            displayName: "Sample Team",
            shortDisplayName: "Sample",
            color: "#000000",
            alternateColor: "#FFFFFF",
            isActive: true,
            logo: "sample_logo_url",
            logos: .shimmerValue,
            records: .shimmerValue,
            venue: .defaultValue,
            standingSummary: "",
            nextEvent: .defaultValue
        )
    }
    
    static var shimmerValues: CountedListModel<TeamModel> {
        let teamModels: [TeamModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: teamModels.count,
            items: teamModels
        )
    }
}

extension TeamModel: ParseableModel {
    static func toObject(fromData data: Any?) -> TeamModel {
        if let data: TeamEntity = data as? TeamEntity {
            return .init(
                id: data.id,
                location: data.location,
                name: data.name,
                abbreviation: data.abbreviation,
                displayName: data.displayName,
                shortDisplayName: data.shortDisplayName,
                color: data.color,
                alternateColor: data.alternateColor,
                isActive: data.isActive,
                logo: data.logo,
                logos: LogoModel.toList(fromData: data.logos),
                records: RecordModel.toList(fromData: data.records),
                venue: VenueModel.toObject(fromData: data.venue),
                standingSummary: data.standingSummary,
                nextEvent: EventModel.toList(fromData: data.nextEvent)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<TeamModel> {
        if let data: CountedListEntity<TeamEntity> = data as? CountedListEntity<TeamEntity> {
            let models: [TeamModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
