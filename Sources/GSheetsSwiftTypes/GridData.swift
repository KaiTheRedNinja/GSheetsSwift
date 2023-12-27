//
//  GridData.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct GridData: Codable, Equatable {
    public static func == (lhs: GridData, rhs: GridData) -> Bool {
        return lhs.rowData == rhs.rowData && lhs.startColumn == rhs.startColumn && lhs.startRow == rhs.startRow
    }
    
    
    public var startRow: Int?
    public var startColumn: Int?
    public var rowData: [RowData]
//    public var rowMetadata: [DimensionProperties]
//    public var columnMetadata: [DimensionProperties]

    enum Keys: CodingKey {
        case startRow, startColumn, rowData
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(startRow, forKey: .startRow)
        try container.encode(startColumn, forKey: .startColumn)
        try container.encode(rowData, forKey: .rowData)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        startRow = try? container.decode(Int.self, forKey: .startRow)
        startColumn = try? container.decode(Int.self, forKey: .startColumn)
        rowData = (try? container.decode([RowData].self, forKey: .rowData)) ?? []
    }
}
