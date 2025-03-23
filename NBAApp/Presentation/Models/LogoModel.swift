//
//  LogoModel.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

class LogoModel: Model {
    private(set) var href: String
    private(set) var width: Int
    private(set) var height: Int
    private(set) var rel: CountedListModel<String>
    private(set) var lastUpdated: String
    
    init(href: String, width: Int, height: Int, rel: CountedListModel<String>, lastUpdated: String) {
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
    
    static var defaultValue: LogoModel {
        return .init(
            href: "",
            width: 0,
            height: 0,
            rel: .defaultValue,
            lastUpdated: ""
        )
    }
    
    static var shimmerValue: LogoModel {
        
        .init(
            href: "",
            width: 0,
            height: 0,
            rel: CountedListModel<String>(count: 3, items: ["PTS", "REB", "AST"]),
            lastUpdated: ""
        )

    }

    static var shimmerValues: CountedListModel<LogoModel> {
        let logos: [LogoModel] = (1...5).map { _ in .shimmerValue }
        return .init(
            count: logos.count,
            items: logos
        )
    }
}

extension LogoModel: ParseableModel {
    static func toObject(fromData data: Any?) -> LogoModel {
        if let data: LogoEntity = data as? LogoEntity {
            
            return .init(
                href: data.href,
                width: data.width,
                height: data.height,
                rel: CountedListModel<String>(count: data.rel.count, items: data.rel.items),
                lastUpdated: data.lastUpdated
            )
        }
        return .defaultValue
    }

    static func toList(fromData data: Any?) -> CountedListModel<LogoModel> {
        if let data: CountedListEntity<LogoEntity> = data as? CountedListEntity<LogoEntity> {
            let models: [LogoModel] = data.items.map { .toObject(fromData: $0) }
            return .init(
                count: data.count,
                items: models
            )
        }
        return .defaultValue
    }
}
