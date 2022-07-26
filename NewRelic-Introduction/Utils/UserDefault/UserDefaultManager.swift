//
//  UserDefaultManager.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/26.
//

import Foundation

/// UserDefaultにアクセスするサンプルコード
class UserDefaultManager {
    init() {}

    /// Description
    /// - Parameter forKey: forKey description
    /// - Returns: description
    func getString(forKey: String) -> String {
        UserDefaults.standard.string(forKey: forKey)!
    }

    /// Description
    /// - Parameters:
    ///   - data: data description
    ///   - forKey: forKey description
    func setString(data: String, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }

    /// Description
    /// - Parameter forKey: forKey description
    /// - Returns: description
    func getBool(forKey: String) -> Bool {
        UserDefaults.standard.bool(forKey: forKey)
    }

    /// Description
    /// - Parameters:
    ///   - data: data description
    ///   - forKey: forKey description
    func setBool(data: Bool, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }

    /// Description
    /// - Parameter forKey: forKey description
    /// - Returns: description
    func getDouble(forKey: String) -> Double {
        UserDefaults.standard.double(forKey: forKey)
    }

    /// Description
    /// - Parameters:
    ///   - data: data description
    ///   - forKey: forKey description
    func setDouble(data: Double, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }

    /// Description
    /// - Parameter forKey: forKey description
    /// - Returns: description
    func getDictionary(forKey: String) -> [String: Any]? {
        UserDefaults.standard.dictionary(forKey: forKey)
    }

    /// Description
    /// - Parameters:
    ///   - data: data description
    ///   - forKey: forKey description
    func setDictionary(data: [String: Any]?, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }

    /// Description
    /// - Parameter forKey: forKey description
    /// - Returns: description
    func getArray(forKey: String) -> [Any]? {
        UserDefaults.standard.array(forKey: forKey)
    }

    /// Description
    /// - Parameters:
    ///   - data: data description
    ///   - forKey: forKey description
    func setArray(data: [Any]?, forKey: String) {
        UserDefaults.standard.set(data, forKey: forKey)
    }

    /// Description
    func removeAll() {
        UserDefaults.standard.removeAll()
        UserDefaults.standard.synchronize()
    }
}

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
