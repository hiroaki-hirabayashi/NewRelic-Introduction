//
//  UserDefaultsClient.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/26.
//

import Foundation

/// UserDefaults用マッピングメソッド定義
protocol UserDefaultsMapper: UserDefaultsMapperBase {
    func domainToEntity(domain: DomainType) -> EntityType
    func entityToDomain(entity: EntityType?) -> ResultType
}

/// UserDefaults用マッピング連想型定義と定数定義
protocol UserDefaultsMapperBase {
    associatedtype DomainType
    associatedtype EntityType: Codable
    associatedtype ResultType

    var userDefaultsKey: String { get }
}

/// UserDefaultsの保存読み込み処理実装クラス
final class UserDefaultsClient: UserDefaultsClientProtocol {
    /// データのセット
    /// - parameter mapper: UserDefaults用マッピングクラス
    /// - parameter entity: 保存対象のEntity
    func setData<Mapper: UserDefaultsMapper>(
        mapper: Mapper,
        entity: Mapper.EntityType
    ) {
        let userDefaults = UserDefaults.standard
        if let data = try? JSONEncoder().encode(entity) {
            userDefaults.set(data, forKey: mapper.userDefaultsKey)
        }
    }

    /// データの読み取り
    /// - parameter mapper: UserDefaults用マッピングクラス
    /// - returns: DomainModel
    func getData<Mapper: UserDefaultsMapper>(mapper: Mapper) -> Mapper.ResultType {
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.data(forKey: mapper.userDefaultsKey) {
            let result = try? JSONDecoder().decode(Mapper.EntityType.self, from: data)
            return mapper.entityToDomain(entity: result)
        }
        return mapper.entityToDomain(entity: nil)
    }

    /// データの削除
    /// - parameter mapper: UserDefaults用マッピングクラス
    func deleteData<Mapper: UserDefaultsMapper>(mapper: Mapper) {
        UserDefaults.standard.removeObject(forKey: mapper.userDefaultsKey)
    }
}

/// UserDefaultsの保存、読み込み、削除処理インターフェース
protocol UserDefaultsClientProtocol {
    func setData<Mapper: UserDefaultsMapper>(mapper: Mapper, entity: Mapper.EntityType)
    func getData<Mapper: UserDefaultsMapper>(mapper: Mapper) -> Mapper.ResultType
    func deleteData<Mapper: UserDefaultsMapper>(mapper: Mapper)
}
