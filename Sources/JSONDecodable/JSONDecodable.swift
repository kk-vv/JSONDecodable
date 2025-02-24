// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftyJSON

public protocol JSONDecodable {
  
  static func decode(from json: JSON) throws -> Self
  
}

extension JSON: JSONDecodable {
  
  public static func decode(from json: JSON) throws -> JSON { json }
}

extension JSONDecodable {
  
  public static func tryDecode(from json: JSON) -> Self? {
    try? decode(from: json)
  }
}

/// JSONDcodingError
public enum JSONDecodingError: LocalizedError {
  
  case keyNotFound(String)
  
  case dataCorrupted(String)
  
  public var errorDescription: String? {
    "JSON decoding error"
  }
  
  public var failureReason: String? {
    switch self {
    case .keyNotFound(let key):
      return "Key <\(key)> not found in JSON object"
    case .dataCorrupted(let message):
      return "Data is corrupted: <\(message)>"
    }
  }
}

extension JSONDecodingError {
  
  /// Check then unwrap the JSON object if it's a dictionary else throw error
  @discardableResult
  public static func throwIfNotDictionary(json: JSON) throws -> [String: JSON] {
    guard let value = json.dictionary else {
      throw JSONDecodingError.dataCorrupted("JSON is not a dictionary")
    }
    return value
  }
}

extension Array: JSONDecodable where Element: JSONDecodable {
  public static func decode(from json: JSON) throws -> Array<Element> {
    guard let array = json.array else {
      return []
    }
    return try array.map { try Element.decode(from: $0) }
  }
}

extension Dictionary: JSONDecodable where Key == String, Value: JSONDecodable {
  
  public static func decode(from json: JSON) throws -> [String: Value] {
    guard let dictionary = json.dictionary else {
      throw JSONDecodingError.dataCorrupted("JSON is not an dictionary")
    }
    return try dictionary.mapValues { try Value.decode(from: $0) }
  }
}

extension String: JSONDecodable {
  public static func decode(from json: JSON) throws -> String {
    json.stringValue
  }
}

extension Int: JSONDecodable {
  public static func decode(from json: JSON) throws -> Int {
    json.intValue
  }
}
