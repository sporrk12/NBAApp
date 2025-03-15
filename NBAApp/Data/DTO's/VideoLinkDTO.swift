//
//  VideoLinkDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

class VideoLinkDTO: DTO {
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
    
    static var defaultValue: VideoLinkDTO {
        .init(
            mobileURL: "",
            apiURL: ""
        )
    }
}

extension VideoLinkDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> VideoLinkDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                mobileURL: data.getDictionary(key: "mobile").getDictionary(key: "source").getString(key: "href"),
                apiURL: data.getDictionary(key: "api").getDictionary(key: "self").getString(key: "href")
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<VideoLinkDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [VideoLinkDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [VideoLinkDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: VideoLinkDTO = .toObject(fromData: data) {
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
