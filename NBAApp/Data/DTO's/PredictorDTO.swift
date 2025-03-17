//
//  PredictorDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 16/03/25.
//

import Foundation

class PredictorDTO: DTO {
    private(set) var header: String
    private(set) var homeProjection: String
    private(set) var awayProjection: String
    
    init(header: String, homeProjection: String, awayProjection: String) {
        self.header = header
        self.homeProjection = homeProjection
        self.awayProjection = awayProjection
    }
    
    func toEntity() -> PredictorEntity {
        return .init(
            header: self.header,
            homeProjection: self.homeProjection,
            awayProjection: self.awayProjection)
        
    }
    
    static var defaultValue: PredictorDTO {
        .init(
            header: "",
            homeProjection: "",
            awayProjection: ""
        )
    }
}

extension PredictorDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> PredictorDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            return .init(
                header: data.getString(key: "header"),
                homeProjection: data.getDictionary(key: "awayTeam").getString(key: "gameProjection"),
                awayProjection: data.getDictionary(key: "awayTeam").getString(key: "teamChanceLoss")
            )
            
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<PredictorDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [PredictorDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [PredictorDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: PredictorDTO = .toObject(fromData: data) {
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


