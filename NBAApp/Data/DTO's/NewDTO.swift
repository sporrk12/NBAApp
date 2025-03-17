//
//  NewDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class NewDTO: DTO {
    private(set) var dataSourceIdentifier: String
    private(set) var type: String
    private(set) var headline: String
    private(set) var description: String
    private(set) var published: String
    private(set) var images: CountedListDTO<ImageDTO>
    private(set) var links: VideoLinkDTO
    
    init(dataSourceIdentifier: String, type: String, headline: String, description: String, published: String, images: CountedListDTO<ImageDTO>, links: VideoLinkDTO) {
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
    
    static var defaultValue: NewDTO {
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
}

extension NewDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> NewDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let images: CountedListDTO<ImageDTO> = ImageDTO.toList(fromData: data.getArray(key: "images")) ?? .defaultValue
            
            return .init(
                dataSourceIdentifier: data.getString(key: "dataSourceIdentifier"),
                type: data.getString(key: "type"),
                headline: data.getString(key: "headline"),
                description: data.getString(key: "description"),
                published: data.getString(key: "published"),
                images: images,
                links: .toObject(fromData: data.getDictionary(key: "links")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<NewDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            let items: [NewDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [NewDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: NewDTO = .toObject(fromData: data) {
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


