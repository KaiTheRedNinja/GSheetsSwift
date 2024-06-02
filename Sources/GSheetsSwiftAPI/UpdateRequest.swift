//
//  UpdateRequest.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation
import GSheetsSwiftTypes

public struct UpdateRequest: Codable {
    // Note: Only ONE of these types is allowed to be populated at any given time
    var updateCells: UpdateCellsRequest?
    var appendCells: AppendCellsRequest?
    var insertDimension: InsertDimensionRequest?

    public init(updateCells: UpdateCellsRequest) {
        self.updateCells = updateCells
    }

    public init(appendCells: AppendCellsRequest) {
        self.appendCells = appendCells
    }

    public init(insertDimension: InsertDimensionRequest) {
        self.insertDimension = insertDimension
    }
}

public struct UpdateCellsRequest: Codable {
    var rows: [RowData]
    var fields: String = "*"
    var start: GridCoordinate
    var range: GridRange?

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

public struct AppendCellsRequest: Codable {
    var sheetId: Int
    var rows: [RowData]
    var fields: String = "*"

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

public struct InsertDimensionRequest: Codable {
    var range: DimensionRange
    var inheritFromBefore: Bool

    public init(range: DimensionRange, inheritFromBefore: Bool) {
        self.range = range
        self.inheritFromBefore = inheritFromBefore
    }
}
