//
//  VideoLinkModel.swift
//  NBAApp
//
//  Created by Emmanuel Granados on 09/03/25.
//

import Foundation

class VideoLinkModel: Model {
    private(set) var mobileURL: String
    private(set) var apiURL: String
    
    init(mobileURL: String, apiURL: String) {
        self.mobileURL = mobileURL
        self.apiURL = apiURL
    }
    
    func toEntity() -> VideoLinkEntity {
        return .init(
            mobileURL: self.mobileURL,
            apiURL: self.apiURL
        )
    }
    
    static var defaultValue: VideoLinkModel {
        .init(
            mobileURL: "",
            apiURL: ""
        )
    }
    
    static var shimmerValue: VideoLinkModel {
        .init(
            mobileURL: "https://sample.mobile.url",
            apiURL: "https://sample.api.url"
        )
    }
    
    static var shimmerValues: CountedListModel<VideoLinkModel> {
        let videoLinkModels: [VideoLinkModel] = (1...10).map { _ in .shimmerValue }
        return .init(
            count: videoLinkModels.count,
            items: videoLinkModels
        )
    }
}

extension VideoLinkModel: ParseableModel {
    static func toObject(fromData data: Any?) -> VideoLinkModel {
        if let data: VideoLinkEntity = data as? VideoLinkEntity {
            return .init(
                mobileURL: data.mobileURL,
                apiURL: data.apiURL
            )
        }
        return .defaultValue
    }
    
    static func toList(fromData data: Any?) -> CountedListModel<VideoLinkModel> {
        if let data: CountedListEntity<VideoLinkEntity> = data as? CountedListEntity<VideoLinkEntity> {
            let models: [VideoLinkModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
