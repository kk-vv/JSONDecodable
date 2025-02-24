//
//  File.swift
//  JSONDecodable
//
//  Created by Felix Hu on 2025/2/24.
//

import Foundation

extension Encodable {

  public func jsonString(_ encoder: JSONEncoder = JSONEncoder()) throws -> String {
    let data = try encoder.encode(self)
    return String(decoding: data, as: UTF8.self)
  }
  
}
