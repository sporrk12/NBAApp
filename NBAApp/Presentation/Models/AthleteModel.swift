//
//  AthleteModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class AthleteModel: Model {
    private(set) var id: String
    private(set) var fullName: String
    private(set) var displayName: String
    private(set) var shortName: String
    private(set) var headshot: String
    private(set) var jersey: String
    private(set) var position: String
    private(set) var team: TeamModel
    private(set) var active: Bool
    
    init(id: String, fullName: String, displayName: String, shortName: String, headshot: String, jersey: String, position: String, team: TeamModel, active: Bool) {
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
    
    static var defaultValue: AthleteModel {
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
    
    static var shimmerValue: AthleteModel {
        .init(
            id: "0000",
            fullName: "Lorem Ipsum",
            displayName: "Lorem Ipsum",
            shortName: "LI",
            headshot: "",
            jersey: "00",
            position: "Forward",
            team: .shimmerValue,
            active: true
        )
    }
    
    static var shimmerValues: CountedListModel<AthleteModel> {
        let athleteModels: [AthleteModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: athleteModels.count,
            items: athleteModels
        )
    }
}

extension AthleteModel: ParseableModel {
    static func toObject(fromData data: Any?) -> AthleteModel {
        if let data: AthleteEntity = data as? AthleteEntity {
            return .init(
                id: data.id,
                fullName: data.fullName,
                displayName: data.displayName,
                shortName: data.shortName,
                headshot: data.headshot,
                jersey: data.jersey,
                position: data.position,
                team: .toObject(fromData: data.team),
                active: data.active
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<AthleteModel> {
        if let data: CountedListEntity<AthleteEntity> = data as? CountedListEntity<AthleteEntity> {
            let models: [AthleteModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}

