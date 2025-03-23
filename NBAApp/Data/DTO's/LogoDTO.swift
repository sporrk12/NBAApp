//
//  LogoDTO.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

class LogoDTO: DTO {
    private(set) var href: String
    private(set) var width: Int
    private(set) var height: Int
    private(set) var rel: CountedListDTO<String>
    private(set) var lastUpdated: String
    
    init(href: String, width: Int, height: Int, rel: CountedListDTO<String>, lastUpdated: String) {
        self.href = href
        self.width = width
        self.height = height
        self.rel = rel
        self.lastUpdated = lastUpdated
    }
    
    func toEntity() -> LogoEntity {
        return .init(
            href: self.href,
            width: self.width,
            height: self.height,
            rel: .init(
                count: self.rel.count,
                items: self.rel.items
            ),
            lastUpdated: self.lastUpdated)
        
    }
    
    static var defaultValue: LogoDTO {
        return .init(
            href: "",
            width: 0,
            height: 0,
            rel: .defaultValue,
            lastUpdated: ""
        )
    }
}

extension LogoDTO: ParseableDTO {
    static func toObject(fromData data: Any?) -> LogoDTO? {
        if let data = data as? [String: Any] {
            
            let athletes: CountedListDTO<AthletesDTO> = AthletesDTO.toList(fromData: data.getArray(key: "athletes")) ?? .defaultValue
            
            return .init(
                href: data.getString(key: "href"),
                width: data.getInt(key: "width"),
                height: data.getInt(key: "height"),
                rel: String.toList(fromData: data.getStringArray(key: "rel")) ?? .defaultValue,
                lastUpdated: data.getString(key: "lastUpdated")
            )
        }
        return nil
    }

    static func toList(fromData data: Any?) -> CountedListDTO<LogoDTO>? {
        if let data = data as? [[String: Any]] {
            let items: [LogoDTO] = data.compactMap { toObject(fromData: $0) }
            return .init(count: items.count, items: items)
        }

        if let data = data as? [String: Any] {
            var dtos: [LogoDTO] = []
            for item in data.getArray(key: "items") {
                if let dto: LogoDTO = .toObject(fromData: item) {
                    dtos.append(dto)
                }
            }
            return .init(count: data.getInt(key: "count"), items: dtos)
        }
        return nil
    }
}


