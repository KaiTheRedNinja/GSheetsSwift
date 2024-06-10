//
//  UpdateRequest.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation
import GSheetsSwiftTypes

/// Represents the data for a HTTP `UPDATE` request
///
/// Only **one** of the following can be populated for any given instance:
/// - `updateCells`
/// - `appendCells`
/// - `insertDimension`
public struct UpdateRequest: Codable {
    var updateCells: UpdateCellsRequest?
    var appendCells: AppendCellsRequest?
    var insertDimension: InsertDimensionRequest?

    /// Creates an update request to update cells
    public init(updateCells: UpdateCellsRequest) {
        self.updateCells = updateCells
    }

    /// Creates an update request ot append cells
    public init(appendCells: AppendCellsRequest) {
        self.appendCells = appendCells
    }

    /// Creates an update request to insert data
    public init(insertDimension: InsertDimensionRequest) {
        self.insertDimension = insertDimension
    }
}

/// Represents the data for updating the cells of a sheet
public struct UpdateCellsRequest: Codable {
    var rows: [RowData]
    var fields: String = "*"
    var start: GridCoordinate
    var range: GridRange?
    
    /// Creates an update cell request
    /// - Parameters:
    ///   - rows: The new row data
    ///   - fields: Fields to update. Defaults to `"*"`, which updates all fields. Refer to the Google
    ///    Sheets REST documentation for full details.
    ///   - start: The coordinates where the new row data starts
    ///   - range: The range to replace data in. Defaults to nil, where it is inferred.
    public init(rows: [RowData],
                fields: String,
                start: GridCoordinate,
                range: GridRange? = nil) {
        self.rows = rows
        self.fields = fields
        self.start = start
        self.range = range
    }
}

/// Represents the data for appending data to the bottom of a sheet's populated data
///
/// For example, if a sheet has 1000 rows but only the first 3 rows are populated with data, this will insert
/// the data starting at row 4.
public struct AppendCellsRequest: Codable {
    var sheetId: Int
    var rows: [RowData]
    var fields: String = "*"
    
    /// Creates an append cells request
    /// - Parameters:
    ///   - sheetId: The ID of the sheet page to add rows to
    ///   - rows: The data of the rows to add
    ///   - fields: Fields to update. Defaults to `"*"`, which updates all fields. Refer to the Google
    ///    Sheets REST documentation for full details.
    public init(
        sheetId: Int,
        rows: [RowData],
        fields: String
    ) {
        self.sheetId = sheetId
        self.rows = rows
        self.fields = fields
    }
}

/// Represents the data for inserting empty rows or columns
public struct InsertDimensionRequest: Codable {
    var range: DimensionRange
    var inheritFromBefore: Bool
    
    /// Creates an insert dimensions request
    /// - Parameters:
    ///   - range: The range of rows or columns to insert
    ///   - inheritFromBefore: True if the new cells should inherit the formatting of the cells above
    ///   or left, false if new cells should inherit the formatting of the cells below or right
    public init(range: DimensionRange, inheritFromBefore: Bool) {
        self.range = range
        self.inheritFromBefore = inheritFromBefore
    }
}
