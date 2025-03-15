//
//  CompetitorModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class CompetitorModel: Model {
    private(set) var id: String
    private(set) var homeAway: String
    private(set) var winner: Bool
    private(set) var team: TeamModel
    private(set) var score: String
    private(set) var lineScores: CountedListModel<LineScoreModel>
    private(set) var statistics: CountedListModel<StatisticsModel>
    private(set) var leaders: CountedListModel<LeaderModel>
    private(set) var records: CountedListModel<RecordModel>
    
    init(id: String, homeAway: String, winner: Bool, team: TeamModel, score: String, lineScores: CountedListModel<LineScoreModel>, statistics: CountedListModel<StatisticsModel>, leaders: CountedListModel<LeaderModel>, records: CountedListModel<RecordModel>) {
        self.id = id
        self.homeAway = homeAway
        self.winner = winner
        self.team = team
        self.score = score
        self.lineScores = lineScores
        self.statistics = statistics
        self.leaders = leaders
        self.records = records
    }
    
    func toEntity() -> CompetitorEntity {
        return .init(
            id: self.id,
            homeAway: self.homeAway,
            winner: self.winner,
            team: self.team.toEntity(),
            score: self.score,
            lineScores: .init(
                count: self.lineScores.count,
                items: self.lineScores.items.map { $0.toEntity() }
            ),
            statistics: .init(
                count: self.statistics.count,
                items: self.statistics.items.map { $0.toEntity() }
            ),
            leaders: .init(
                count: self.leaders.count,
                items: self.leaders.items.map { $0.toEntity() }
            ),
            records: .init(
                count: self.records.count,
                items: self.records.items.map { $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: CompetitorModel {
        .init(
            id: "",
            homeAway: "",
            winner: false,
            team: .defaultValue,
            score: "",
            lineScores: .defaultValue,
            statistics: .defaultValue,
            leaders: .defaultValue,
            records: .defaultValue
        )
    }
    
    static var shimmerValue: CompetitorModel {
        .init(
            id: "0000",
            homeAway: "home",
            winner: false,
            team: .shimmerValue,
            score: "100",
            lineScores: .shimmerValue,
            statistics: .shimmerValue,
            leaders: .shimmerValue,
            records: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<CompetitorModel> {
        let competitorModels: [CompetitorModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: competitorModels.count,
            items: competitorModels
        )
    }
}

extension CompetitorModel: ParseableModel {
    static func toObject(fromData data: Any?) -> CompetitorModel {
        if let data: CompetitorEntity = data as? CompetitorEntity {
            return .init(
                id: data.id,
                homeAway: data.homeAway,
                winner: data.winner,
                team: .toObject(fromData: data.team),
                score: data.score,
                lineScores: LineScoreModel.toList(fromData: data.lineScores),
                statistics: StatisticsModel.toList(fromData: data.statistics),
                leaders: LeaderModel.toList(fromData: data.leaders),
                records: RecordModel.toList(fromData: data.records)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<CompetitorModel> {
        if let data: CountedListEntity<CompetitorEntity> = data as? CountedListEntity<CompetitorEntity> {
            let models: [CompetitorModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
