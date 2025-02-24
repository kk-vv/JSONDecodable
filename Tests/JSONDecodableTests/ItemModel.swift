//
//  File.swift
//  JSONDecodable
//
//  Created by Felix Hu on 2025/2/24.
//

import Foundation
import JSONDecodable
import SwiftyJSON

struct Item: JSONDecodable, Equatable {
  let name: String
  let id: Int
  let keywords: [String]
  let orkeywords: [String]
  
  static func decode(from json: JSON) throws -> Item {
    try JSONDecodingError.throwIfNotDictionary(json: json)
    return .init(
      name: json["name"].stringValue,
      id: json["id"].intValue,
      keywords: [String].tryDecode(from: json["keywords"]) ?? [],
      orkeywords: json["keywords"].arrayValue.map { $0.stringValue }
    )
  }
}

struct List: JSONDecodable, Equatable {
  let title: String
  let description: String?
  let items: [Item]
  
  static func decode(from json: JSON) throws -> List {
    try JSONDecodingError.throwIfNotDictionary(json: json)
    return .init(
      title: json["title"].stringValue,
      description: json["description"].string,
      items: try [Item].decode(from: json["items"])
    )
  }
}
