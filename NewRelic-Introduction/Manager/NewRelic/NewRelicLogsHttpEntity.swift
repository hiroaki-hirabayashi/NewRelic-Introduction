//
//  NewRelicLogsHttpEntity.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/19.
//

import Foundation

struct NewRelicLogsHttpEntity: Encodable {
    /// ログの内容
    var logs: [MessageEntity]
}

//extension NewRelicLogsHttpEntity {
//    struct MessageEntity: Encodable {
//        // NewRelicでJSON解析されてトップのフィールドに配置される
//        var message: LogsFormat
//    }
//}
