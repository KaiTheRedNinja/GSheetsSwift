//
//  RowData.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

/// Represents the data of a row
public struct RowData: Codable, Equatable {
    public static func == (lhs: RowData, rhs: RowData) -> Bool {
        return lhs.values == rhs.values
    }
    
    /// The data within the cells in the row
    public var values: [CellData]

    /// Creates a row data instance from the data inside the row
    public init(values: [CellData]) {
        self.values = values
    }
}
