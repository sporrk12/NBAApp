//
//  LogoEntity.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 20/03/25.
//

struct LogoEntity: Entity {
    let href: String
    let width: Int
    let height: Int
    let rel: CountedListEntity<String>
    let lastUpdated: String
    
    static var defaultValue: LogoEntity {
        .init(
            href: "",
            width: 0,
            height: 0,
            rel: .defaultValue,
            lastUpdated: ""
        )
    }
    
}
