//
//  LeadersDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class LeadersDTO: DTO {
    private(set) var team: TeamDTO
    private(set) var leaders: LeaderDTO
    
    init(team: TeamDTO, leaders: LeaderDTO) {
        self.team = team
        self.leaders = leaders
    }
    
    func toEntity() -> LeadersEntity {
        return .init(
            team: self.team.toEntity(),
            leaders: self.leaders.toEntity()
        )
    }
    
    static var defaultValue: LeadersDTO {
        .init(
            team: .defaultValue,
            leaders: .defaultValue
        )
    }
}

extension LeadersDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LeadersDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            
            return .init(
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                leaders: .toObject(fromData: data.getDictionary(key: "leaders")) ?? .defaultValue
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<LeadersDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [LeadersDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [LeadersDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: LeadersDTO = .toObject(fromData: data) {
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
