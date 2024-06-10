//
//  Sheet.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// Represents a sheet page within a ``Spreadsheet``
public struct Sheet: Codable, Equatable {
    public static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs.data == rhs.data && lhs.properties == rhs.properties
    }
    
    /// The properties of the sheet
    public var properties: SheetProperties
    /// The grid data within the sheet.
    ///
    /// For a continuous sheet, where there are no empty rows between populated rows,
    /// there will only be one item in this array.
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
