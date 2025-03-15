//
//  VideoDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class VideoDTO: DTO {
    private(set) var id: Int
    private(set) var headline: String
    private(set) var thumbnail: String
    private(set) var duration: Int
    private(set) var videoLinks: VideoLinkDTO
    
    init(id: Int, headline: String, thumbnail: String, duration: Int, videoLinks: VideoLinkDTO) {
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
    
    static var defaultValue: VideoDTO {
        .init(
            id: 0,
            headline: "",
            thumbnail: "",
            duration: 0,
            videoLinks: .defaultValue
        )
    }
}

extension VideoDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> VideoDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                id: data.getInt(key: "id"),
                headline: data.getString(key: "headline"),
                thumbnail: data.getString(key: "thumbnail"),
                duration: data.getInt(key: "duration"),
                videoLinks: .toObject(fromData: data.getDictionary(key: "links")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<VideoDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [VideoDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [VideoDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: VideoDTO = .toObject(fromData: data) {
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
