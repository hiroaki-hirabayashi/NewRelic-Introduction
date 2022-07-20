//
//  LogsFormat.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/20.
//

import Foundation

/// ログレベル
public enum LogLevel: String, Codable {
    /// 性能ログ (個々の処理の開始・終了時間)
    case trace
    /// デバッグログ (任意)
    case debug
    /// アクセスログ、通信ログ（クラス名、メソッド名等）
    case info
    /// 業務エラーログ（継続可能）
    case warn
    /// システムエラーログ（継続可能）、監視ログ
    case error
    /// 業務・システムエラーログ（継続不可能）
    case fatal
}

/// AWS CloudWatchLogs NewRelic LogFormat
public struct LogsFormat: Codable {
    static let appName = "comado-native-ios"

    /// タイムスタンプ
    let timestamp: String
    /// app名
    let app: String
    ///  コンテンツ名
    let contents: String
    /// アプリケーションバージョン
    let version: String
    /// traceId
    let traceId: String
    /// ログレベル
    let level: LogLevel
    /// ユーザーID
    let userId: String
    /// ログの内容
    let message: String

    init(
        timestamp: String,
        app: String,
        contents: String,
        version: String,
        traceId: String,
        level: LogLevel,
        userId: String,
        message: String
    ) {
        self.timestamp = timestamp
        self.app = app
        self.contents = contents
        self.version = version
        self.traceId = traceId
        self.level = level
        self.userId = userId
        self.message = message
    }

    public init(
        contents: String,
        version: String,
        level: LogLevel,
        message: String
    ) {
        // 共通
        self.app = Self.appName
        self.traceId = NanoIDManager.shared.getLaunchId()
        self.userId = UserManager.shared.getUserID()
        let now = Date()
        let formatter = ISO8601DateFormatter()
        self.timestamp = formatter.string(from: now)

        // コンテンツ
        self.contents = contents
        self.version = version

        // 各ログ
        self.level = level
        self.message = message
    }
}
