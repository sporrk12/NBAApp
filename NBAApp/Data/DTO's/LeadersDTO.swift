//
//  LeadersDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class LeadersDTO: DTO {
    private(set) var team: TeamDTO
    private(set) var leaders: CountedListDTO<LeaderDTO>
    
    init(team: TeamDTO, leaders: CountedListDTO<LeaderDTO>) {
        self.team = team
        self.leaders = leaders
    }
    
    func toEntity() -> LeadersEntity {
        return .init(
            team: self.team.toEntity(),
            leaders: .init(
                count: self.leaders.count,
                items: self.leaders.items.compactMap { $0.toEntity() }
            )
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
            
            let leaders: CountedListDTO<LeaderDTO> = LeaderDTO.toList(fromData: data.getArray(key: "leaders")) ?? .defaultValue
            
            return .init(
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                leaders: leaders
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
