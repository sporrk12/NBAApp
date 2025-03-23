//
//  GameDetailCatalogDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class GameDetailCatalogDTO: DTO {
    private(set) var boxscore: BoxScoreDTO
    private(set) var venue: VenueDTO
    private(set) var lastFiveGames: CountedListDTO<LastFiveGameDTO>
    private(set) var leaders: CountedListDTO<LeadersDTO>
    private(set) var injuries: CountedListDTO<InjuriesDTO>
    private(set) var predictor: PredictorDTO
    private(set) var header: HeaderDTO
    private(set) var news: CountedListDTO<NewDTO>
    private(set) var videos: CountedListDTO<VideoDTO>
    
    init(boxscore: BoxScoreDTO, venue: VenueDTO, lastFiveGames: CountedListDTO<LastFiveGameDTO>, leaders: CountedListDTO<LeadersDTO>, injuries: CountedListDTO<InjuriesDTO>, predictor: PredictorDTO, header: HeaderDTO, news: CountedListDTO<NewDTO>, videos: CountedListDTO<VideoDTO>) {
        self.boxscore = boxscore
        self.venue = venue
        self.lastFiveGames = lastFiveGames
        self.leaders = leaders
        self.injuries = injuries
        self.predictor = predictor
        self.header = header
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
            header: self.header.toEntity(),
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
    
    static var defaultValue: GameDetailCatalogDTO {
        return .init(
            boxscore: .defaultValue,
            venue: .defaultValue,
            lastFiveGames: .defaultValue,
            leaders: .defaultValue,
            injuries: .defaultValue,
            predictor: .defaultValue,
            header: .defaultValue,
            news: .defaultValue,
            videos: .defaultValue
        )
    }
}

extension GameDetailCatalogDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> GameDetailCatalogDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let lastFiveGames: CountedListDTO<LastFiveGameDTO> = LastFiveGameDTO.toList(fromData: data.getArray(key: "lastFiveGames")) ?? .defaultValue
            
            let leaders: CountedListDTO<LeadersDTO> = LeadersDTO.toList(fromData: data.getArray(key: "leaders")) ?? .defaultValue
            
            let injuries: CountedListDTO<InjuriesDTO> = InjuriesDTO.toList(fromData: data.getArray(key: "injuries")) ?? .defaultValue
            
            let news: CountedListDTO<NewDTO> = NewDTO.toList(fromData: data.getDictionary(key: "news").getArray(key: "articles")) ?? .defaultValue
            
            let videos: CountedListDTO<VideoDTO> = VideoDTO.toList(fromData: data.getArray(key: "videos")) ?? .defaultValue
            
            return .init(
                boxscore: .toObject(fromData: data.getDictionary(key: "boxscore")) ?? .defaultValue,
                venue: .toObject(fromData: data.getDictionary(key: "gameInfo").getDictionary(key: "venue")) ?? .defaultValue,
                lastFiveGames: lastFiveGames,
                leaders: leaders,
                injuries: injuries,
                predictor: .toObject(fromData: data.getDictionary(key: "predictor")) ?? .defaultValue,
                header: .toObject(fromData: data.getDictionary(key: "header")) ?? .defaultValue,
                news: news,
                videos: videos
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<GameDetailCatalogDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [GameDetailCatalogDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [GameDetailCatalogDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: GameDetailCatalogDTO = .toObject(fromData: data) {
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

