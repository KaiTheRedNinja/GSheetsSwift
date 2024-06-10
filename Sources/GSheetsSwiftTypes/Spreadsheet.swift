//
//  Spreadsheet.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

/// Represents a Google Spreadsheet
public struct Spreadsheet: Codable {
    /// The ID of the spreadsheet
    public var spreadsheetId: String
    /// The sheets within the spreadsheet
    public var sheets: [Sheet]
}
