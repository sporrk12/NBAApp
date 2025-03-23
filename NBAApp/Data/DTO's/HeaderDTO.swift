//
//  HeaderDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

import Foundation

class HeaderDTO: DTO {
    private(set) var id: String
    private(set) var timeValid: Bool
    private(set) var competitions: CountedListDTO<CompetitionDTO>
    
    init(id: String, timeValid: Bool, competitions: CountedListDTO<CompetitionDTO>) {
        self.id = id
        self.timeValid = timeValid
        self.competitions = competitions
    }
    
    func toEntity() -> HeaderEntity {
        return  .init(
            id: self.id,
            timeValid: self.timeValid,
            competititons: .init(
                count: self.competitions.count,
                items: self.competitions.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: HeaderDTO {
        .init(
            id: "",
            timeValid: false,
            competitions: .defaultValue
        )
    }
}

extension HeaderDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> HeaderDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let competitions: CountedListDTO<CompetitionDTO> =
            CompetitionDTO.toList(fromData: data.getArray(key: "competitions")) ?? .defaultValue
            return .init(
                id: data.getString(key: "id"),
                timeValid: data.getBool(key: "timeValid"),
                competitions: competitions
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<HeaderDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [HeaderDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [HeaderDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: HeaderDTO = .toObject(fromData: data) {
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



