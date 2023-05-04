
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let peopleListModel = try? JSONDecoder().decode(PeopleListModel.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - PeopleListModel
struct PeopleListModel: Codable {
    let count: Int?
    let next, previous: String?
    let results: [Person]?
}

// MARK: - Result
struct Person: Codable, Hashable {
    let name: String
    let height, mass, hairColor, skinColor, eyeColor, birthYear, gender, homeworld, created, edited, url: String?
    let films, species, vehicles, starships: [String]?

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
