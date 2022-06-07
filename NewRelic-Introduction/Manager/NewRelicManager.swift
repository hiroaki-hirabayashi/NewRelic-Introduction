//
//  NewRelicManager.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/07.
//

import Foundation
import NewRelic

/// NewRelicイベント送信マネージャー
public class NewRelicManager {
    /// Singleton
    public static let shared = NewRelicManager()
    
    /// 外部からはインスタンス化しない
    public init() {
    }
    
    /// 手動でクラッシュさせる場合
    public func crashNow(logMessage: String) {
        NewRelic.crashNow(logMessage)
    }
    
    /// 初期化
    public func configure() {
        // TODO: -  NewRelicのロギングレベルを上る
//        NRLogger.setLogLevels(NRLogLevelALL.rawValue)
        // TODO: - 以下に本番アクセストークンを設定する
        NewRelic.start(withApplicationToken: "")
    }
}
