//
//  StringDataExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

extension String {
    func toJsonObject() -> Any? {
        if let value: Data = self.data(using: .utf8) {
            do {
                if let value: [String: Any] = try JSONSerialization.jsonObject(with: value) as? [String: Any] {
                    return value
                }
            } catch {
                return nil
            }
        }
        return nil
    }
}

extension String: DTO, Entity {
    static var defaultValue: String {
        return ""
    }
}

extension String: ParseableDTO {
    static func toObject(fromData data: Any?) -> String? {
        
        if let stringValue = data as? String {
            return stringValue
        }
        return nil
    }
    
    static func toList(fromData data: Any?) -> CountedListDTO<String>? {
        // Caso 1: Array de strings directamente
        if let stringArray = data as? [String] {
            return .init(
                count: stringArray.count,
                items: stringArray
            )
        }
        
        // Caso 2: Formato CountedList {count, items}
        if let data = data as? [String: Any] {
        
            if let namesArray = data["names"] as? [String] {
                return .init(
                    count: namesArray.count,
                    items: namesArray
                )
            }
            
            // Los otros casos que ya teníamos...
            if let items = data["items"] as? [String] {
                return .init(
                    count: data["count"] as? Int ?? items.count,
                    items: items
                )
            }
            
            // Intenta extraer si los items son diccionarios
            let stringItems = (data.getArray(key: "items") as? [[String: Any]])?.compactMap { toObject(fromData: $0) } ?? []
            if !stringItems.isEmpty {
                return .init(
                    count: data.getInt(key: "count"),
                    items: stringItems
                )
            }
        }
        
        // Caso 3: Array de diccionarios donde cada uno contiene un string
        if let dictArray = data as? [[String: Any]] {
            let strings = dictArray.compactMap { toObject(fromData: $0) }
            if !strings.isEmpty {
                return .init(
                    count: strings.count,
                    items: strings
                )
            }
        }
        
        return nil
    }
}
