//
//  NanoID.swift
//  NewRelic-Introduction
//
//  Created by Hiroaki-Hirabayashi on 2022/07/20.
//

import Foundation

/// USAGE
///
/// Nano ID with default alphabet (0-9a-zA-Z_~) and length (21 chars)
/// let id = NanoID.new()
///
/// ナノID（デフォルトのアルファベットと指定された長さ）
/// Nano ID with default alphabet and given length
/// let id = NanoID.new(12)
///
/// アルファベットと長さを指定したナノID
/// Nano ID with given alphabet and length
/// let id = NanoID.new(alphabet: .uppercasedLatinLetters, size: 15)
///
/// カスタムパラメータをプリセットしたNanoID
/// Nano ID with preset custom parameters
/// let nanoID = NanoID(alphabet: .lowercasedLatinLetters,.numbers, size:10)
/// let idFirst = nanoID.new()
/// let idSecond = nanoID.new()

class NanoID {
    
    /// Shared Parameters
    private var size: Int
    private var alphabet: String
    
    /// 共有パラメータを持つインスタンスを生成する
    init(alphabet: NanoIDAlphabet..., size: Int) {
        self.size = size
        self.alphabet = NanoIDHelper.parse(alphabet)
    }
    
    /// Shared Parameterを用いたNanoIDの生成
    func new() -> String {
        return NanoIDHelper.generate(from: alphabet, of: size)
    }
    
    /// デフォルトのパラメータ
    private static let defaultSize = 21
    private static let defaultAphabet = NanoIDAlphabet.urlSafe.toString()
    
    /// デフォルトのパラメータでNanoIDを生成
    static func new() -> String {
        return NanoIDHelper.generate(from: defaultAphabet, of: defaultSize)
    }
    
    /// 指定のパラメータを用いてNanoIDを生成
    static func new(alphabet: NanoIDAlphabet..., size: Int) -> String {
        let charactersString = NanoIDHelper.parse(alphabet)
        return NanoIDHelper.generate(from: charactersString, of: size)
    }
    
    /// デフォルトのアルファベットと指定したサイズでNanoIDを生成
    static func new(_ size: Int) -> String {
        return NanoIDHelper.generate(from: NanoID.defaultAphabet, of: size)
    }
}

fileprivate class NanoIDHelper {
    
    /// Parses input alphabets into a string
    static func parse(_ alphabets: [NanoIDAlphabet]) -> String {
        
        var stringCharacters = ""
        
        for alphabet in alphabets {
            stringCharacters.append(alphabet.toString())
        }
        
        return stringCharacters
    }
    
    /// 入力されたアルファベットを文字列にパースする
    static func generate(from alphabet: String, of length: Int) -> String {
        var nanoID = ""
        
        for _ in 0..<length {
            let randomCharacter = NanoIDHelper.randomCharacter(from: alphabet)
            nanoID.append(randomCharacter)
        }
        
        return nanoID
    }
    
    /// 指定された文字列からランダムな文字を返す
    static func randomCharacter(from string: String) -> Character {
        let randomNum = Int(arc4random_uniform(UInt32(string.count)))
        let randomIndex = string.index(string.startIndex, offsetBy: randomNum)
        return string[randomIndex]
    }
}

enum NanoIDAlphabet {
    case urlSafe
    case uppercasedLatinLetters
    case lowercasedLatinLetters
    case numbers
    
    func toString() -> String {
        switch self {
        case .uppercasedLatinLetters, .lowercasedLatinLetters, .numbers:
            return self.chars()
        case .urlSafe:
            return ("\(NanoIDAlphabet.uppercasedLatinLetters.chars())\(NanoIDAlphabet.lowercasedLatinLetters.chars())\(NanoIDAlphabet.numbers.chars())-_")
        }
    }
    
    private func chars() -> String {
        switch self {
        case .uppercasedLatinLetters:
            return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case .lowercasedLatinLetters:
            return "abcdefghijklmnopqrstuvwxyz"
        case .numbers:
            return "1234567890"
        default:
            return ""
        }
    }
}
