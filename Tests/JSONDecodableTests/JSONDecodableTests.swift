import Testing
@testable import JSONDecodable
@testable import SwiftyJSON

@Test func testDecode() async throws {
  // Write your test here and use APIs like `#expect(...)` to check expected conditions.
  let item1 = Item(name: "SwiftyJSON", id: 1, keywords: ["swift", "json"], orkeywords: ["swift", "json"])
  let item2 = Item(name: "JSONDecodable", id: 2, keywords: ["swift", "json", "decodable"], orkeywords: ["swift", "json", "decodable"])
  let list = List(title: "JSON", description: nil, items: [item1, item2])
  
  let data = """
  {
    "items": [
      {
        "name": "SwiftyJSON",
        "keywords": [
          "swift",
          "json"
        ],
        "id": 1,
      },
      {
        "keywords": [
          "swift",
          "json",
          "decodable"
        ],
        "id": 2,
        "name": "JSONDecodable",
      }
    ],
    "title": "JSON"
  }
  """
    
  //let decodedList = List.tryDecode(from: try JSON(data: data.data(using: .utf8)!))
  let decodedList = List.tryDecode(from: JSON(parseJSON: data))

  #expect(decodedList == list)
}
