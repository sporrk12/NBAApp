//
//  HighlightDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class HighlightDTO: DTO {
    private(set) var id: Int
    private(set) var headline: String
    private(set) var description: String
    private(set) var duration: Int
    private(set) var thumbnail: String
    private(set) var videoLinks: VideoLinkDTO
    
    init(id: Int, headline: String, description: String, duration: Int, thumbnail: String, videoLinks: VideoLinkDTO) {
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
            videoLinks: .init(
                mobileURL: self.videoLinks.mobileURL,
                apiURL: self.videoLinks.apiURL
            )
        )
    }
    
    static var defaultValue: HighlightDTO {
        .init(
            id: 0,
            headline: "",
            description: "",
            duration: 0,
            thumbnail: "",
            videoLinks: .defaultValue
        )
    }
}

extension HighlightDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> HighlightDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                id: data.getInt(key: "id"),
                headline: data.getString(key: "headline"),
                description: data.getString(key: "description"),
                duration: data.getInt(key: "duration"),
                thumbnail: data.getString(key: "thumbnail"),
                videoLinks: .toObject(fromData: data.getDictionary(key: "links")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<HighlightDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [HighlightDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [HighlightDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: HighlightDTO = .toObject(fromData: data) {
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
