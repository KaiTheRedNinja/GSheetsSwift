//
//  GridCoordinate.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

/// Represents the coordinate of a cell
public struct GridCoordinate: Codable {
    /// The id of the sheet page that the cell belongs to
    public var sheetId: Int
    /// The row of the cell
    public var rowIndex: Int
    /// The column of the cell
    public var columnIndex: Int
    
    /// Creates a grid coordinate
    /// - Parameters:
    ///   - sheetId: The id of the sheet page that the cell belongs to
    ///   - rowIndex: The row of the cell
    ///   - columnIndex: The column of the cell
    public init(sheetId: Int, rowIndex: Int, columnIndex: Int) {
        self.sheetId = sheetId
        self.rowIndex = rowIndex
        self.columnIndex = columnIndex
    }
}
