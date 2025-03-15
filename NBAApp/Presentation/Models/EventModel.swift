//
//  EventModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class EventModel: Model {
    private(set) var id: String
    private(set) var date: String
    private(set) var name: String
    private(set) var shortName: String
    private(set) var competitions: CountedListModel<CompetitionModel>
    private(set) var status: StatusModel
    
    init(id: String, date: String, name: String, shortName: String, competitions: CountedListModel<CompetitionModel>, status: StatusModel) {
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
            date : self.date,
            name: self.name,
            shortName: self.shortName,
            competitions: .init(
                count: self.competitions.count,
                items: self.competitions.items.map { $0.toEntity() }
            ),
            status: self.status.toEntity()
        )
    }
    
    static var defaultValue: EventModel {
        .init(
            id: "",
            date: "",
            name: "",
            shortName: "",
            competitions: .defaultValue,
            status: .defaultValue
        )
    }
    
    static var shimmerValue: EventModel {
        .init(
            id: "0000",
            date: "00/00/0000",
            name: "Lorem Ipsum",
            shortName: "LI",
            competitions: .shimmerValue,
            status: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<EventModel> {
        let eventModels: [EventModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: eventModels.count,
            items: eventModels
        )
    }
}

extension EventModel: ParseableModel {
    static func toObject(fromData data: Any?) -> EventModel {
        if let data: EventEntity = data as? EventEntity {
            return .init(
                id: data.id,
                date: data.date,
                name: data.name,
                shortName: data.shortName,
                competitions: CompetitionModel.toList(fromData: data.competitions),
                status: StatusModel.toObject(fromData: data.status)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<EventModel> {
        if let data: CountedListEntity<EventEntity> = data as? CountedListEntity<EventEntity> {
            let models: [EventModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
