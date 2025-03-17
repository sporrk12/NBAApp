//
//  LastFiveGameModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class LastFiveGameModel: Model {
    private(set) var displayOrder: Int
    private(set) var team: TeamModel
    private(set) var events: CountedListModel<GameEventModel>
    
    init(displayOrder: Int, team: TeamModel, events: CountedListModel<GameEventModel>) {
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
                items: self.events.items.compactMap { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: LastFiveGameModel {
        .init(
            displayOrder: 0,
            team: .defaultValue,
            events: .defaultValue
        )
    }
    
    static var shimmerValue: LastFiveGameModel {
        .init(
            displayOrder: 1,
            team: .shimmerValue,
            events: CountedListModel<GameEventModel>(
                count: 5,
                items: (1...5).map { _ in .shimmerValue }
            )
        )
    }
    
    static var shimmerValues: CountedListModel<LastFiveGameModel> {
        let lastFiveGamesModels: [LastFiveGameModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: lastFiveGamesModels.count,
            items: lastFiveGamesModels
        )
    }
}

extension LastFiveGameModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LastFiveGameModel {
        if let data: LastFiveGameEntity = data as? LastFiveGameEntity {
            return .init(
                displayOrder: data.displayOrder,
                team: TeamModel.toObject(fromData: data.team),
                events: GameEventModel.toList(fromData: data.events)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<LastFiveGameModel> {
        if let data: CountedListEntity<LastFiveGameEntity> = data as? CountedListEntity<LastFiveGameEntity> {
            let models: [LastFiveGameModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
