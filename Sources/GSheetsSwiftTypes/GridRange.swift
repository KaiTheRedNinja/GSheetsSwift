//
//  GridRange.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

public struct GridRange: Codable {
    public var sheetId: Int
    public var startRowIndex: Int
    public var endRowIndex: Int
    public var startColumnIndex: Int
    public var endColumnIndex: Int

    public init(sheetId: Int, startRowIndex: Int, endRowIndex: Int, startColumnIndex: Int, endColumnIndex: Int) {
        self.sheetId = sheetId
        self.startRowIndex = startRowIndex
        self.endRowIndex = endRowIndex
        self.startColumnIndex = startColumnIndex
        self.endColumnIndex = endColumnIndex
    }
}
