//
//  NewRelicManager.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/07.
//

import Alamofire
import Gzip
import NewRelic
import Realm
import SwiftUI

/// NewRelicイベント送信マネージャー
public class NewRelicManager {
    /// Singleton
    public static let shared = NewRelicManager()
    private let token = "AA640d54c34609f64256555cb0cec2dbb695a041ce-NRMA"
    
    /// 外部からはインスタンス化しない
    public init() {
    }
    
    /// 手動でクラッシュさせる場合
    public func crashNow(logMessage: String) {
        NewRelic.crashNow(logMessage)
    }
    
    /// 初期化
    func configure() {
        // TODO: -  NewRelicのロギングレベルを上る
//        NRLogger.setLogLevels(NRLogLevelALL.rawValue)
        // TODO: - 以下に本番アクセストークンを設定する
        NewRelic.start(withApplicationToken: token)
    }
    
    /// ネットワーク状態でNewRelicにログ送信する
    public func sendNewRelic() {
        if Network.shared.isOnline() {
            self.postNewRelic(
                app: "comado-predev-web",
                version: "1.2.3",
                traceId: "trace-id-1234",
                level: "info",
                userId: "******",
                message: "ネットワークあり6/21",
                isRequestRepeat: NewRelicLogsSendQueue.isLogged()
            )
            print("送信")
        } else {
            self.saveLogs(
                app: "comado-predev-web",
                version: "1.2.3",
                traceId: "trace-id-1234",
                level: "info",
                userId: "******",
                message: "ネットワークなし"
            )
        }
    }

    /// ログ送信
    public func postNewRelic(
        timestamp: Double = Date().timeIntervalSince1970,
        app: String? = nil,
        version: String? = nil,
        traceId: String? = nil,
        level: String? = nil,
        userId: String? = nil,
        message: String? = nil,
        isRequestRepeat: Bool = false
    ) {
        let common = [
            "attributes": [
                "logtype": "accesslogs",
                "service": "login-service",
                "hostname": "login.example.com",
            ]
        ]
        var logList = [[String: Any]]()
        var dict = [String: Any]()
        if !isRequestRepeat,
            let app = app,
            let version = version,
            let traceId = traceId,
            let level = level,
            let userId = userId,
            let message = message {
            dict =
                [
                    "timestamp": timestamp,
                    "app": app,
                    "version": version,
                    "traceId": traceId,
                    "level": level,
                    "userId": userId,
                    "message": message,
                ]
            logList.append(dict)
        }
        let getLogs = NewRelicLogsSendQueue.getLogs(isRequestRepeat: isRequestRepeat)
        for log in getLogs {
            dict =
                [
                    "timestamp": log.timestamp,
                    "app": log.app,
                    "version": log.version,
                    "traceId": log.traceId,
                    "level": log.level,
                    "userId": log.userId,
                    "message": log.message,
                ]
            logList.append(dict)
        }
        let params = ["common": common, "logs": logList] as [String: Any]
        let baseURL = "https://log-api.newrelic.com/log/v1"
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Content-Encoding": "gzip",
            "Api-Key": "c757a98c812ee5344afc3df4454233eec44bNRAL",
            "Accept": "*/*",
        ]
        let body = try? JSONSerialization.data(withJSONObject: [params], options: [])
        AF.request(
            baseURL,
            method: .post,
            parameters: body,
            encoder: GzipPostEncoder(),
            headers: headers
        )
        .responseJSON { response in
            print(response.response?.statusCode)
            if let data = response.data {
                let message = String(data: data, encoding: .utf8)
                print(message)
            }
            switch response.result {
            case .success(let value):
                print("success : \(value)")
                NewRelicLogsSendQueue.deleteLogs()
            case .failure(let error):
                print(error)
                if let app = app,
                    let version = version,
                    let traceId = traceId,
                    let level = level,
                    let userId = userId,
                    let message = message {
                    self.saveLogs(
                        timestamp: timestamp,
                        app: app,
                        version: version,
                        traceId: traceId,
                        level: level,
                        userId: userId,
                        message: message
                    )
                }
            }
        }
    }

    /// ログ登録
    public func saveLogs(
        timestamp: Double = Date().timeIntervalSince1970,
        app: String,
        version: String,
        traceId: String,
        level: String,
        userId: String,
        message: String
    ) {
        NewRelicLogsSendQueue.setLogs(
            app: app,
            version: version,
            traceId: traceId,
            level: level,
            userId: userId,
            timestamp: Int(timestamp),
            message: message
        )
    }
}

struct GzipPostEncoder: ParameterEncoder {
    func encode<Parameters>(_ parameters: Parameters?, into request: URLRequest) throws
        -> URLRequest where Parameters: Encodable {
        guard let parameters = parameters else { return request }

        var request = request
        request.httpBody = try (parameters as? Data)?.gzipped()
        return request
    }
}
