//
//  GridRange.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

/// A range that a grid can occupy
public struct GridRange: Codable {
    /// The ID of the sheet page
    public var sheetId: Int
    /// The index of the starting row
    public var startRowIndex: Int
    /// The index of the ending row
    public var endRowIndex: Int
    /// The index of the starting column
    public var startColumnIndex: Int
    /// The index of the ending column
    public var endColumnIndex: Int
    
    /// Creates a grid range
    /// - Parameters:
    ///   - sheetId: The ID of the sheet page
    ///   - startRowIndex: The index of the starting row
    ///   - endRowIndex: The index of the ending row
    ///   - startColumnIndex: The index of the starting column
    ///   - endColumnIndex: The index of the ending column
    public init(sheetId: Int, startRowIndex: Int, endRowIndex: Int, startColumnIndex: Int, endColumnIndex: Int) {
        self.sheetId = sheetId
        self.startRowIndex = startRowIndex
        self.endRowIndex = endRowIndex
        self.startColumnIndex = startColumnIndex
        self.endColumnIndex = endColumnIndex
    }
}
