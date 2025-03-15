//
//  VideoModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class VideoModel: Model {
    private(set) var id: Int
    private(set) var headline: String
    private(set) var thumbnail: String
    private(set) var duration: Int
    private(set) var videoLinks: VideoLinkModel
    
    init(id: Int, headline: String, thumbnail: String, duration: Int, videoLinks: VideoLinkModel) {
        self.id = id
        self.headline = headline
        self.thumbnail = thumbnail
        self.duration = duration
        self.videoLinks = videoLinks
    }
    
    func toEntity() -> VideoEntity {
        return .init(
            id: self.id,
            headline: self.headline,
            thumbnail: self.thumbnail,
            duration: self.duration,
            videoLinks: self.videoLinks.toEntity()
        )
    }
    
    static var defaultValue: VideoModel {
        .init(
            id: 0,
            headline: "",
            thumbnail: "",
            duration: 0,
            videoLinks: .defaultValue
        )
    }
    
    static var shimmerValue: VideoModel {
        .init(
            id: 1234,
            headline: "Incredible Play!",
            thumbnail: "sample_thumbnail_url",
            duration: 45,
            videoLinks: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<VideoModel> {
        let videoModels: [VideoModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: videoModels.count,
            items: videoModels
        )
    }
}

extension VideoModel: ParseableModel {
    static func toObject(fromData data: Any?) -> VideoModel {
        if let data: VideoEntity = data as? VideoEntity {
            return .init(
                id: data.id,
                headline: data.headline,
                thumbnail: data.thumbnail,
                duration: data.duration,
                videoLinks: VideoLinkModel.toObject(fromData: data.videoLinks)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<VideoModel> {
        if let data: CountedListEntity<VideoEntity> = data as? CountedListEntity<VideoEntity> {
            let models: [VideoModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
