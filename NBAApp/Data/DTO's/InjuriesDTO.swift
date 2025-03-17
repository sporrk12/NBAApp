//
//  InjuriesDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 15/03/25.
//

import Foundation

class InjuriesDTO: DTO {
    private(set) var team: TeamDTO
    private(set) var injuries: CountedListDTO<InjuryDTO>
    
    init(team: TeamDTO, injuries: CountedListDTO<InjuryDTO>) {
        self.team = team
        self.injuries = injuries
    }
    
    func toEntity() -> InjuriesEntity {
        return .init(
            team: self.team.toEntity(),
            injuries: .init(
                count: self.injuries.count,
                items: self.injuries.items.compactMap{ $0.toEntity() }
            )
        )
    }
    
    static var defaultValue: InjuriesDTO {
        return .init(
            team: .defaultValue,
            injuries: .defaultValue
        )
    }
}

extension InjuriesDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> InjuriesDTO? {
        if let data: [String: Any] = data as? [String: Any] {
            
            let injuries: CountedListDTO<InjuryDTO> = InjuryDTO.toList(fromData: data.getArray(key: "injuries")) ?? .defaultValue
            
            return .init(
                team: .toObject(fromData: data.getDictionary(key: "team")) ?? .defaultValue,
                injuries: injuries
            )
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<InjuriesDTO>? {
        if let data: [[String: Any]] = data as? [[String: Any]] {
            
            let items: [InjuriesDTO] = data.compactMap { toObject(fromData: $0) }
            
            return .init(
                count: items.count,
                items: items
            )
        }
        
        if let data: [String: Any] = data as? [String: Any] {
            var dtos: [InjuriesDTO] = []
            for data in data.getArray(key: "items") {
                if let dto: InjuriesDTO = .toObject(fromData: data) {
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
