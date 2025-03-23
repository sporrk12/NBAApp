//
//  CompetitionModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class CompetitionModel: Model {
    private(set) var date: String
    private(set) var venue: VenueModel
    private(set) var competitors: CountedListModel<CompetitorModel>
    private(set) var status: StatusModel
    private(set) var highlights: CountedListModel<HighlightModel>
    private(set) var headlines: CountedListModel<HeadlineModel>
    
    init(date: String, venue: VenueModel, competitors: CountedListModel<CompetitorModel>, status: StatusModel, highlights: CountedListModel<HighlightModel>, headlines: CountedListModel<HeadlineModel>) {
        self.date = date
        self.venue = venue
        self.competitors = competitors
        self.status = status
        self.highlights = highlights
        self.headlines = headlines
    }
    
    func toEntity() -> CompetitionEntity {
        return .init(
            date: self.date,
            venue: self.venue.toEntity(),
            competitors: .init(
                count: self.competitors.count,
                items: self.competitors.items.map { $0.toEntity() }
            ),
            status: self.status.toEntity(),
            highlights: .init(
                count: self.highlights.count,
                items: self.highlights.items.map { $0.toEntity() }
            ),
            headlines: .init(
                count: self.headlines.count,
                items: self.headlines.items.map { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: CompetitionModel {
        .init(
            date: "",
            venue: .defaultValue,
            competitors: .defaultValue,
            status: .defaultValue,
            highlights: .defaultValue,
            headlines: .defaultValue
        )
    }
    
    static var shimmerValue: CompetitionModel {
        .init(
            date: "321332",
            venue: .shimmerValue,
            competitors: .shimmerValue,
            status: .shimmerValue,
            highlights: .shimmerValue,
            headlines: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<CompetitionModel> {
        let competitionModels: [CompetitionModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: competitionModels.count,
            items: competitionModels
        )
    }
}

extension CompetitionModel: ParseableModel {
    static func toObject(fromData data: Any?) -> CompetitionModel {
        if let data: CompetitionEntity = data as? CompetitionEntity {
            return .init(
                date: data.date,
                venue: .toObject(fromData: data.venue),
                competitors: CompetitorModel.toList(fromData: data.competitors),
                status: StatusModel.toObject(fromData: data.status),
                highlights: HighlightModel.toList(fromData: data.highlights),
                headlines: HeadlineModel.toList(fromData: data.headlines)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<CompetitionModel> {
        if let data: CountedListEntity<CompetitionEntity> = data as? CountedListEntity<CompetitionEntity> {
            let models: [CompetitionModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
