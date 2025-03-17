//
//  GameDetailCatalogModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class GameDetailCatalogModel: Model {
    private(set) var boxscore: BoxScoreModel
    private(set) var venue: VenueModel
    private(set) var lastFiveGames: CountedListModel<LastFiveGameModel>
    private(set) var leaders: CountedListModel<LeadersModel>
    private(set) var injuries: CountedListModel<InjuriesModel>
    private(set) var predictor: PredictorModel
    private(set) var news: CountedListModel<NewModel>
    private(set) var videos: CountedListModel<VideoModel>

    init(boxscore: BoxScoreModel, venue: VenueModel, lastFiveGames: CountedListModel<LastFiveGameModel>, leaders: CountedListModel<LeadersModel>, injuries: CountedListModel<InjuriesModel>, predictor: PredictorModel, news: CountedListModel<NewModel>, videos: CountedListModel<VideoModel>) {
        self.boxscore = boxscore
        self.venue = venue
        self.lastFiveGames = lastFiveGames
        self.leaders = leaders
        self.injuries = injuries
        self.predictor = predictor
        self.news = news
        self.videos = videos
    }

    func toEntity() -> GameDetailCatalogEntity {
        return .init(
            boxscore: self.boxscore.toEntity(),
            venue: self.venue.toEntity(),
            lastFiveGames: .init(
                count: self.lastFiveGames.count,
                items: self.lastFiveGames.items.compactMap { $0.toEntity() }
            ),
            leaders: .init(
                count: self.leaders.count,
                items: self.leaders.items.compactMap { $0.toEntity() }
            ),
            injuries: .init(
                count: self.injuries.count,
                items: self.injuries.items.compactMap { $0.toEntity() }
            ),
            predictor: self.predictor.toEntity(),
            news: .init(
                count: self.news.count,
                items: self.news.items.compactMap { $0.toEntity() }
            ),
            videos: .init(
                count: self.videos.count,
                items: self.videos.items.compactMap { $0.toEntity() }
            )
        )
    }

    static var defaultValue: GameDetailCatalogModel {
        return .init(
            boxscore: .defaultValue,
            venue: .defaultValue,
            lastFiveGames: .defaultValue,
            leaders: .defaultValue,
            injuries: .defaultValue,
            predictor: .defaultValue,
            news: .defaultValue,
            videos: .defaultValue
        )
    }

    static var shimmerValue: GameDetailCatalogModel {
        return .init(
            boxscore: .shimmerValue,
            venue: .shimmerValue,
            lastFiveGames: CountedListModel<LastFiveGameModel>(
                count: 5,
                items: (1...5).map { _ in .shimmerValue }
            ),
            leaders: CountedListModel<LeadersModel>(
                count: 3,
                items: (1...3).map { _ in .shimmerValue }
            ),
            injuries: CountedListModel<InjuriesModel>(
                count: 2,
                items: (1...2).map { _ in .shimmerValue }
            ),
            predictor: .shimmerValue,
            news: CountedListModel<NewModel>(
                count: 3,
                items: (1...3).map { _ in .shimmerValue }
            ),
            videos: CountedListModel<VideoModel>(
                count: 3,
                items: (1...3).map { _ in .shimmerValue }
            )
        )
    }

    static var shimmerValues: CountedListModel<GameDetailCatalogModel> {
        let gameDetails: [GameDetailCatalogModel] = (1...3).map { _ in .shimmerValue }
        return .init(
            count: gameDetails.count,
            items: gameDetails
        )
    }
}

extension GameDetailCatalogModel: ParseableModel {
    static func toObject(fromData data: Any?) -> GameDetailCatalogModel {
        if let data: GameDetailCatalogEntity = data as? GameDetailCatalogEntity {
            return .init(
                boxscore: BoxScoreModel.toObject(fromData: data.boxscore),
                venue: VenueModel.toObject(fromData: data.venue),
                lastFiveGames: LastFiveGameModel.toList(fromData: data.lastFiveGames),
                leaders: LeadersModel.toList(fromData: data.leaders),
                injuries: InjuriesModel.toList(fromData: data.injuries),
                predictor: PredictorModel.toObject(fromData: data.predictor),
                news: NewModel.toList(fromData: data.news),
                videos: VideoModel.toList(fromData: data.videos)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<GameDetailCatalogModel> {
        if let data: CountedListEntity<GameDetailCatalogEntity> = data as? CountedListEntity<GameDetailCatalogEntity> {
            let models: [GameDetailCatalogModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
