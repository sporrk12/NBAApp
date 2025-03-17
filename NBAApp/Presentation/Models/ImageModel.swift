//
//  ImageModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class ImageModel: Model {
    private(set) var name: String
    private(set) var caption: String
    private(set) var height: String
    private(set) var width: String
    private(set) var url: String

    init(name: String, caption: String, height: String, width: String, url: String) {
        self.name = name
        self.caption = caption
        self.height = height
        self.width = width
        self.url = url
    }

    func toEntity() -> ImageEntity {
        return .init(
            name: self.name,
            caption: self.caption,
            height: self.height,
            width: self.width,
            url: self.url
        )
    }

    static var defaultValue: ImageModel {
        .init(
            name: "",
            caption: "",
            height: "",
            width: "",
            url: ""
        )
    }

    static var shimmerValue: ImageModel {
        .init(
            name: "Sample Image",
            caption: "This is a sample image",
            height: "500",
            width: "800",
            url: "https://via.placeholder.com/800x500"
        )
    }

    static var shimmerValues: CountedListModel<ImageModel> {
        let images: [ImageModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: images.count,
            items: images
        )
    }
}

extension ImageModel: ParseableModel {
    static func toObject(fromData data: Any?) -> ImageModel {
        if let data: ImageEntity = data as? ImageEntity {
            return .init(
                name: data.name,
                caption: data.caption,
                height: data.height,
                width: data.width,
                url: data.url
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<ImageModel> {
        if let data: CountedListEntity<ImageEntity> = data as? CountedListEntity<ImageEntity> {
            let models: [ImageModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
