//
//  DriverModel.swift
//  FormulaStars
//
//  Created by MEWO on 25.04.2022.
//

import Foundation
struct DriverModel : Codable {
    var items = [Items]()

    enum CodingKeys: String, CodingKey {

        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)!
    }
}
struct Items : Codable {
    var id = 0
    var name = ""
    var point = 0

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case name = "name"
        case point = "point"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        point = try values.decodeIfPresent(Int.self, forKey: .point) ?? 0
    }
}
