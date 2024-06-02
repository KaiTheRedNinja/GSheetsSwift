//
//  UpdateRequest.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation
import GSheetsSwiftTypes

public struct UpdateRequest: Codable {
    // Note: Only ONE of these types is allowed at any given time
    var updateCells: UpdateCellsRequest?
    var appendCells: AppendCellsRequest?

    public init(updateCells: UpdateCellsRequest) {
        self.updateCells = updateCells
    }

    public init(appendCells: AppendCellsRequest) {
        self.appendCells = appendCells
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
