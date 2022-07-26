//
//  UserDefaultsKey.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/22.
//

import Foundation

/// UserDefaultsKey定義
class UserDefaultsKey {
    /// 推奨アプリバージョンのスキップ情報を保存する
    static let platformCommon_skipAppVersion: String = "platformCommon_skipAppVersion"
    /// ユーザー属性情報を保存する
    static let platformCommon_userAttribute: String = "platformCommon_userAttribute"
    /// ユーザー個人情報を保存する
    static let platformCommon_userPersonalData: String = "platformCommon_userPersonalData"
    /// プッシュ通知設定を保存する
    static let platformCommon_pushNotificationSetting: String =
        "platformCommon_pushNotificationSetting"
    /// ユーザーIDを保存する
    static let common_userID: String = "platformCommon_userId"
}

/// Keychain定義定義
class KeychainKey {
    /// Bundle Identifier
    static let platformCommon_bundleIdentifier = "com.suntory-kenko.comado.app.platform-commonApp"
    /// セッションIDを保存する
    static let platformCommon_sessionKeychain: String = "platformCommon_sessionKeychain"
}
