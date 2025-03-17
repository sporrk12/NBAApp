//
//  ImageDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class ImageDTO: DTO {
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
    
    static var defaultValue: ImageDTO {
        .init(
            name: "",
            caption: "",
            height: "",
            width: "",
            url: ""
        )
    }
}

extension ImageDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> ImageDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                name: data.getString(key: "name"),
                caption: data.getString(key: "caption"),
                height: data.getString(key: "height"),
                width: data.getString(key: "width"),
                url: data.getString(key: "url")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<ImageDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [ImageDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [ImageDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: ImageDTO = .toObject(fromData: data) {
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



