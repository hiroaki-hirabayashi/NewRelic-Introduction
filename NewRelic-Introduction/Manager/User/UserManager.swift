//
//  UserManager.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/20.
//

import Foundation

/// アプリを使用中のユーザー(ID)を管理する
/// どのレイヤーにも属さないロガーから取得するため
class UserManager {
    /// singleton
    static let shared = UserManager()

    // TODO: ログイン後にユーザーIDを取得して、本メソッドを呼び出す。
    // TODO: ログアウトがあれば空を設定する。
    /// ユーザーIDを保存します。
    func setUserID(_ userID: String) {
        UserDefaults.standard.set(userID, forKey: UserDefaultsKey.platformCommon_userId)
    }

    /// ユーザーIDを取得します。
    func getUserID() -> String {
        let userID = UserDefaults.standard.string(forKey: UserDefaultsKey.platformCommon_userId)
        return userID ?? ""
    }
}

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
    static let platformCommon_userId: String = "platformCommon_userId"
}

/// Keychain定義定義
class KeychainKey {
    /// Bundle Identifier
    static let platformCommon_bundleIdentifier = "com.suntory-kenko.comado.app.platform-commonApp"
    /// セッションIDを保存する
    static let platformCommon_sessionKeychain: String = "platformCommon_sessionKeychain"
}
