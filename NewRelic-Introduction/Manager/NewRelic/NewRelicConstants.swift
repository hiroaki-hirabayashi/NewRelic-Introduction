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
    static let token = "AA640d54c34609f64256555cb0cec2dbb695a041ce-NRMA"
    static let baseURL = "https://log-api.newrelic.com/log/v1"
#else // 本番用
    static let apiKey = ""
    static let token = ""
    static let baseURL = ""
#endif
}

//AA640d54c34609f64256555cb0cec2dbb695a041ce-NRMA
