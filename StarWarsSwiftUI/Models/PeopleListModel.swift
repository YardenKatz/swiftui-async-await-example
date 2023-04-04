
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let peopleListModel = try? JSONDecoder().decode(PeopleListModel.self, from: jsonData)

import Foundation
import SwiftUI

// MARK: - PeopleListModel
struct PeopleListModel: Codable {
    let count: Int?
    let next: String?
    let previous: JSONNull?
    let results: [Person]?
}

// MARK: - Result
struct Person: Codable, Hashable {
    let name, height: String
    let mass, hairColor: String?
    let skinColor, eyeColor, birthYear: String?
    let gender: Gender?
    let homeworld: String?
    let films, species, vehicles, starships: [String]?
    let created, edited: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor
        case skinColor
        case eyeColor
        case birthYear
        case gender, homeworld, films, species, vehicles, starships, created, edited, url
    }
}

enum Gender: String, Codable {
    case female = "female"
    case male = "male"
    case nA = "n/a"
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
