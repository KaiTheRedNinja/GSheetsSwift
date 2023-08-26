//
//  Spreadsheet.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

public struct Spreadsheet: Codable {
    public var spreadsheetId: String
    public var sheets: [Sheet]
}
