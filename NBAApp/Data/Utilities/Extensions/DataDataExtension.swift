//
//  DataDataExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

extension Data {
    func toJsonObject<T>() -> T? {
        do {
            return try JSONSerialization.jsonObject(with: self) as? T
        } catch {
            return nil
        }
    }
}
