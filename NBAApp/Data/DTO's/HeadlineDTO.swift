//
//  HeadlineDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 08/03/25.
//

import Foundation

class HeadlineDTO: DTO {
    private(set) var type: String
    private(set) var description: String
    private(set) var shortLinkText: String
    private(set) var video: VideoDTO
    
    init(type: String, description: String, shortLinkText: String, video: VideoDTO) {
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
    
    static var defaultValue: HeadlineDTO {
        .init(
            type: "",
            description: "",
            shortLinkText: "",
            video: .defaultValue
        )
    }
}

extension HeadlineDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> HeadlineDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                type: data.getString(key: "type"),
                description: data.getString(key: "description"),
                shortLinkText: data.getString(key: "shortLinkText"),
                video: .toObject(fromData: data.getDictionary(key: "links")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<HeadlineDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [HeadlineDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [HeadlineDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: HeadlineDTO = .toObject(fromData: data) {
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

