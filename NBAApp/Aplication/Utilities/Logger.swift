//
//  Logger.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

struct Logger {
    private init() {}

    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
        print("[NBAApp] - ", terminator: "")
        print(items, separator: separator, terminator: terminator)
#endif
    }
}
