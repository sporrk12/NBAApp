//
//  ArticleModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class NewModel: Model {
    private(set) var dataSourceIdentifier: String
    private(set) var type: String
    private(set) var headline: String
    private(set) var description: String
    private(set) var published: String
    private(set) var images: CountedListModel<ImageModel>
    private(set) var links: VideoLinkModel

    init(dataSourceIdentifier: String, type: String, headline: String, description: String, published: String, images: CountedListModel<ImageModel>, links: VideoLinkModel) {
        self.dataSourceIdentifier = dataSourceIdentifier
        self.type = type
        self.headline = headline
        self.description = description
        self.published = published
        self.images = images
        self.links = links
    }

    func toEntity() -> NewEntity {
        return .init(
            dataSourceIdentifier: self.dataSourceIdentifier,
            type: self.type,
            headline: self.headline,
            description: self.description,
            published: self.published,
            images: .init(
                count: self.images.count,
                items: self.images.items.compactMap { $0.toEntity() }
            ),
            links: self.links.toEntity()
        )
    }

    static var defaultValue: NewModel {
        return .init(
            dataSourceIdentifier: "",
            type: "",
            headline: "",
            description: "",
            published: "",
            images: .defaultValue,
            links: .defaultValue
        )
    }

    static var shimmerValue: NewModel {
        return .init(
            dataSourceIdentifier: "123456",
            type: "News",
            headline: "Exciting Game Recap!",
            description: "Detailed breakdown of last night's game.",
            published: "2025-03-16",
            images: CountedListModel<ImageModel>(
                count: 3,
                items: (1...3).map { _ in .shimmerValue }
            ),
            links: .shimmerValue
        )
    }

    static var shimmerValues: CountedListModel<NewModel> {
        let articles: [NewModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: articles.count,
            items: articles
        )
    }
}

extension NewModel: ParseableModel {
    static func toObject(fromData data: Any?) -> NewModel {
        if let data: NewEntity = data as? NewEntity {
            return .init(
                dataSourceIdentifier: data.dataSourceIdentifier,
                type: data.type,
                headline: data.headline,
                description: data.description,
                published: data.published,
                images: ImageModel.toList(fromData: data.images),
                links: VideoLinkModel.toObject(fromData: data.links)
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<NewModel> {
        if let data: CountedListEntity<NewEntity> = data as? CountedListEntity<NewEntity> {
            let models: [NewModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
