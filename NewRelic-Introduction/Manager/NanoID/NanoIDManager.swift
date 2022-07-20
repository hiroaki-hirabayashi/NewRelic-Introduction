//
//  NanoIDManager.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/20.
//

import Foundation

/// NanoIDを管理、生成
public class NanoIDManager {
    /// singleton
    public static let shared = NanoIDManager()
    private let launchNanoID: String

    private init() {
        launchNanoID = Self.generate()
    }

    /// NanoIDを生成します
    ///
    /// APIのリクエストなどに使用します。
    public static func generate() -> String {
        return NanoID.new()
    }

    /// アプリ起動毎に生成するnanoIDを取得します
    ///
    /// アプリのログなどに使用します。
    public func getLaunchId() -> String {
        return launchNanoID
    }
}
