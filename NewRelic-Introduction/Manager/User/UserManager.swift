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
        UserDefaults.standard.set(userID, forKey: UserDefaultsKey.common_userID)
    }

    /// ユーザーIDを取得します。
    func getUserID() -> String {
        let userID = UserDefaults.standard.string(forKey: UserDefaultsKey.common_userID)
        return userID ?? ""
    }
}
