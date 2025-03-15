//
//  HeadlineModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class HeadlineModel: Model {
    private(set) var type: String
    private(set) var description: String
    private(set) var shortLinkText: String
    private(set) var video: VideoModel
    
    init(type: String, description: String, shortLinkText: String, video: VideoModel) {
        self.type = type
        self.description = description
        self.shortLinkText = shortLinkText
        self.video = video
    }
    
    func toEntity() -> HeadlineEntity {
        return .init(
            type: self.type,
            description: self.description,
            shortLinkText: self.shortLinkText,
            video: self.video.toEntity()
        )
    }
    
    static var defaultValue: HeadlineModel {
        .init(
            type: "",
            description: "",
            shortLinkText: "",
            video: .defaultValue
        )
    }
    
    static var shimmerValue: HeadlineModel {
        .init(
            type: "Breaking News",
            description: "This is a sample headline for a major event!",
            shortLinkText: "Read more",
            video: .shimmerValue
        )
    }
    
    static var shimmerValues: CountedListModel<HeadlineModel> {
        let headlineModels: [HeadlineModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: headlineModels.count,
            items: headlineModels
        )
    }
}

extension HeadlineModel: ParseableModel {
    static func toObject(fromData data: Any?) -> HeadlineModel {
        if let data: HeadlineEntity = data as? HeadlineEntity {
            return .init(
                type: data.type,
                description: data.description,
                shortLinkText: data.shortLinkText,
                video: VideoModel.toObject(fromData: data.video)
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<HeadlineModel> {
        if let data: CountedListEntity<HeadlineEntity> = data as? CountedListEntity<HeadlineEntity> {
            let models: [HeadlineModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
