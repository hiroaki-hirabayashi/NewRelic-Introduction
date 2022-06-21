//
//  NewRelicLogsSendQueue.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/21.
//

import Foundation
import RealmSwift

/// Realmを使用したQueue
public class NewRelicLogsSendQueue: Object {
    @Persisted var timestamp = 0
    @Persisted var app = ""
    @Persisted var version = ""
    @Persisted var traceId = ""
    @Persisted var level = ""
    @Persisted var userId = ""
    @Persisted var message = ""

    // swiftlint:disable function_parameter_count
    // swiftlint:disable force_try
    /// ログをセットする
    public static func setLogs(
        app: String,
        version: String,
        traceId: String,
        level: String,
        userId: String,
        timestamp: Int,
        message: String
    ) {
        let realm = try! Realm()
        let newRelicLogsSendQueue = NewRelicLogsSendQueue()
        newRelicLogsSendQueue.app = app
        newRelicLogsSendQueue.version = version
        newRelicLogsSendQueue.level = level
        newRelicLogsSendQueue.userId = userId
        newRelicLogsSendQueue.timestamp = timestamp
        newRelicLogsSendQueue.message = message
        try! realm.write {
            realm.add(newRelicLogsSendQueue)
        }
    }

    /// ログを取得する
    public static func getLogs(isRequestRepeat: Bool) -> [NewRelicLogsSendQueue] {
        let realm = try! Realm()
        let results = realm.objects(NewRelicLogsSendQueue.self)
        var list = [NewRelicLogsSendQueue]()
        var getLogCount = 0
        let firstSetLogsCount = 99
        let setLogsCount = 100
        if isRequestRepeat {
            getLogCount = setLogsCount
        } else {
            /// 初回のみ引数が加算される為、99
            getLogCount = firstSetLogsCount
        }
        for i in 0..<results.count {
            list.append(results[i])
            if list.count >= getLogCount {
                break
            }
        }
        print("AAA\(Realm.Configuration.defaultConfiguration.fileURL!)")
        return list
    }

    /// ログを削除する
    public static func deleteLogs() {
        let realm = try! Realm()
        let results = realm.objects(NewRelicLogsSendQueue.self)
        if results.count <= 100 {
            // 100件以下の場合全件削除
            try! realm.write {
                realm.deleteAll()
            }
        } else {
            // 100件以上の場合100件削除
            var list = [NewRelicLogsSendQueue]()
            for i in 0..<100 {
                list.append(results[i])
            }
            try! realm.write {
                realm.delete(list)
            }
        }
    }
    /// Log 有true 無false
    public static func isLogged() -> Bool {
        var isLogged = false
        let realm = try! Realm()
        let results = realm.objects(NewRelicLogsSendQueue.self)
        if results.count >= 1 {
            isLogged = true
        }
        return isLogged
    }
}
