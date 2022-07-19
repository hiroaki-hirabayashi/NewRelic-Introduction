//
//  NewRelicConstants.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/19.
//

import Foundation

class NewRelicConstants {
#if DEBUG
    // TODO: - ライセンスキー系はどこに置くか
    static let apiKey = ""
    static let token = ""
    static let baseURL = "https://log-api.newrelic.com/log/v1"
#else // 本番用
    static let apiKey = ""
    static let token = ""
    static let baseURL = ""
#endif
}

