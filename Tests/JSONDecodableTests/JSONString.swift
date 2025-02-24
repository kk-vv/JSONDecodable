//
//  JSONString.swift
//  JSONDecodable
//
//  Created by Felix Hu on 2025/2/24.
//

import Testing

struct CodableItem: Codable {
  let name: String
  let id: Int
  let keywords: [String]
}

@Test func ouputJsonString() async throws {
  let item = CodableItem(name: "SwiftyJSON", id: 1, keywords: ["swift", "json"])
  print(try item.jsonString())
}
