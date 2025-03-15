//
//  HighlightModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class HighlightModel: Model {
    private(set) var id: Int
    private(set) var headline: String
    private(set) var description: String
    private(set) var duration: Int
    private(set) var thumbnail: String
    private(set) var videoLinks: VideoLinkModel
    
    init(id: Int, headline: String, description: String, duration: Int, thumbnail: String, videoLinks: VideoLinkModel) {
        self.id = id
        self.headline = headline
        self.description = description
        self.duration = duration
        self.thumbnail = thumbnail
        self.videoLinks = videoLinks
    }
    
    func toEntity() -> HighlightEntity {
        return .init(
            id: self.id,
            headline: self.headline,
            description: self.description,
            duration: self.duration,
            thumbnail: self.thumbnail,
            videoLinks: self.videoLinks.toEntity()
        )
    }
    
    static var defaultValue: HighlightModel {
        .init(
            id: 0,
            headline: "",
            description: "",
            duration: 0,
            thumbnail: "",
            videoLinks: .defaultValue
        )
    }
    
    static var shimmerValue: HighlightModel {
        .init(
            id: 1234,
            headline: "Amazing Dunk!",
            description: "Watch this incredible dunk from last night's game!",
            duration: 30,
            thumbnail: "sample_thumbnail_url",
            videoLinks: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<HighlightModel> {
        let highlightModels: [HighlightModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: highlightModels.count,
            items: highlightModels
        )
    }
}

extension HighlightModel: ParseableModel {
    static func toObject(fromData data: Any?) -> HighlightModel {
        if let data: HighlightEntity = data as? HighlightEntity {
            return .init(
                id: data.id,
                headline: data.headline,
                description: data.description,
                duration: data.duration,
                thumbnail: data.thumbnail,
                videoLinks: VideoLinkModel.toObject(fromData: data.videoLinks)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<HighlightModel> {
        if let data: CountedListEntity<HighlightEntity> = data as? CountedListEntity<HighlightEntity> {
            let models: [HighlightModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
