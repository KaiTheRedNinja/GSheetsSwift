//
//  Sheet.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct Sheet: Codable, Equatable {
    public static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs.data == rhs.data && lhs.properties == rhs.properties
    }
    
    public var properties: SheetProperties
    public var data: [GridData]

    enum Keys: CodingKey {
        case properties, data
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(properties, forKey: .properties)
        try container.encode(data, forKey: .data)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        properties = try container.decode(SheetProperties.self, forKey: .properties)
        data = (try? container.decode([GridData].self, forKey: .data)) ?? []
    }
}
