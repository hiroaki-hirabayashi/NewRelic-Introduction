//
//  Network.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/06/21.
//

import Network

/// ネットワークの変更を監視
public class Network {
    /// シングルトン
    public static let shared = Network()
    /// モニター
    public let monitor = NWPathMonitor()
    /// ネットワーク監視開始
    public func setUp() {
        monitor.pathUpdateHandler = { _ in
        }
        let queue = DispatchQueue(label: "Monitor")

        monitor.start(queue: queue)
    }
    /// オンライン判定
    public func isOnline() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}

