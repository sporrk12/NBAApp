//
//  DictionaryExtension.swift
//  NBAApp
//
//  Created by Emmanuel  Granados on 09/03/25.
//

import Foundation

extension Dictionary {
    var isNotEmpty: Bool { !self.isEmpty }

    func hasKey(_ key: Key) -> Bool {
        return self.keys.contains(key)
    }

    func hasNoKey(_ key: Key) -> Bool {
        return !self.hasKey(key)
    }

    func getDictionary(keys: [Key], defaultValue: [String: Any] = [:]) -> [String: Any] {
        var value: [String: Any] = defaultValue

        for key in keys {
            let valueTmp: [String: Any] = self.getDictionary(key: key, defaultValue: defaultValue)
            if !valueTmp.isEmpty {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getDictionary(key: Key, defaultValue: [String: Any] = [:]) -> [String: Any] {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: [String: Any] = self[key] as? [String: Any] {
            return value
        }

        if let value: String = self[key] as? String {
            if let value: [String: Any] = value.toJsonObject() as? [String: Any] {
                return value
            }
        }

        return defaultValue
    }

    func getArray(keys: [Key], defaultValue: [[String: Any]] = []) -> [[String: Any]] {
        var value: [[String: Any]] = defaultValue

        for key in keys {
            let valueTmp: [[String: Any]] = self.getArray(key: key, defaultValue: defaultValue)
            if !valueTmp.isEmpty {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getArray(key: Key, defaultValue: [[String: Any]] = []) -> [[String: Any]] {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: [[String: Any]] = self[key] as? [[String: Any]] {
            return value
        }

        if let value: String = self[key] as? String {
            if let value: Data = value.data(using: .utf8) {
                do {
                    if let value: [[String: Any]] = try JSONSerialization.jsonObject(with: value) as? [[String: Any]] {
                        return value
                    }
                } catch {
                    return defaultValue
                }
            }
        }

        return defaultValue
    }
    
    func getStringArray(key: Key, defaultValue: [String] = []) -> [String] {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: [String] = self[key] as? [String] {
            return value
        }

        if let value: String = self[key] as? String {
            if let data: Data = value.data(using: .utf8) {
                do {
                    if let jsonArray: [String] = try JSONSerialization.jsonObject(with: data) as? [String] {
                        return jsonArray
                    }
                } catch {
                    return defaultValue
                }
            }
        }

        return defaultValue
    }

    func getString(keys: [Key], defaultValue: String = "") -> String {
        var value: String = defaultValue

        for key in keys {
            let valueTmp: String = self.getString(key: key, defaultValue: defaultValue)
            if !valueTmp.isEmpty {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getString(key: Key, defaultValue: String = "") -> String {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: String = self[key] as? String {
            return value
        }

        return defaultValue
    }

    func getInt(keys: [Key], defaultValue: Int = 0) -> Int {
        var value: Int = defaultValue

        for key in keys {
            let valueTmp: Int = self.getInt(key: key, defaultValue: defaultValue)
            if valueTmp != 0 {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getInt(key: Key, defaultValue: Int = 0) -> Int {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: Int = self[key] as? Int {
            return value
        }

        if let value: String = self[key] as? String {
            if let value: Int = Int(value) {
                return value
            }
        }

        return defaultValue
    }

    func getDouble(keys: [Key], defaultValue: Double = 0.0) -> Double {
        var value: Double = defaultValue

        for key in keys {
            let valueTmp: Double = self.getDouble(key: key, defaultValue: defaultValue)
            if valueTmp != 0.0 {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getDouble(key: Key, defaultValue: Double = 0.0) -> Double {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: Double = self[key] as? Double {
            return value
        }

        if let value: String = self[key] as? String {
            if let value: Double = Double(value) {
                return value
            }
        }

        return defaultValue
    }

    func getFloat(keys: [Key], defaultValue: Float = 0.0) -> Float {
        var value: Float = defaultValue

        for key in keys {
            let valueTmp: Float = self.getFloat(key: key, defaultValue: defaultValue)
            if valueTmp != 0.0 {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getFloat(key: Key, defaultValue: Float = 0.0) -> Float {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: Float = self[key] as? Float {
            return value
        }

        if let value: String = self[key] as? String {
            if let value: Float = Float(value) {
                return value
            }
        }

        return defaultValue
    }

    func getBool(keys: [Key], defaultValue: Bool = false) -> Bool {
        var value: Bool = defaultValue

        for key in keys {
            let valueTmp: Bool = self.getBool(key: key, defaultValue: defaultValue)
            if !valueTmp {
                value = valueTmp
                break
            }
        }

        return value
    }

    func getBool(key: Key, defaultValue: Bool = false) -> Bool {
        if self.hasNoKey(key) {
            return defaultValue
        }

        if let value: Bool = self[key] as? Bool {
            return value
        }

        if let value: Int = self[key] as? Int {
            if value == 0 {
                return false
            }

            if value == 1 {
                return true
            }

            return defaultValue
        }

        if let value: Double = self[key] as? Double {
            if value == 0.0 {
                return false
            }

            if value == 1.0 {
                return true
            }

            return defaultValue
        }

        if let value: Float = self[key] as? Float {
            if value == 0.0 {
                return false
            }

            if value == 1.0 {
                return true
            }

            return defaultValue
        }

        if let value: String = self[key] as? String {
            let value: String = value.replacingOccurrences(of: "\\s", with: "", options: .regularExpression).lowercased()
            if value == "true" || value == "yes" || value == "si" || value == "1" {
                return true
            }

            if value == "false" || value == "not" || value == "no" || value == "0" {
                return false
            }
        }

        return defaultValue
    }

    func getDate(keys: [Key], dateFormatter: String = "yyyy-MM-dd HH:mm:ss", defaultValue: Date? = nil) -> Date? {
        var value: Date? = defaultValue

        for key in keys {
            if let date: Date = self.getDate(key: key, dateFormatter: dateFormatter, defaultValue: defaultValue) {
                value = date
                break
            }
        }

        return value
    }

    func getDate(key: Key, dateFormatter: String = "yyyy-MM-dd HH:mm:ss", defaultValue: Date? = nil) -> Date? {
        if let value: Date = self[key] as? Date {
            return value
        }

        if let value: String = self[key] as? String {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = dateFormatter

            if let value: Date = formatter.date(from: value) {
                return value
            }
        }

        return defaultValue
    }

    func toData() -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: self)
        } catch {
            return Data()
        }
    }

    func toString() -> String {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted])
            return String(data: jsonData, encoding: .utf8) ?? ""
        } catch {
            return "json serialization error"
        }
    }
}

