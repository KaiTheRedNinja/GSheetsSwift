//
//  DimensionRange.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct DimensionRange: Codable {
    public var sheetId: Int
    public var dimension: DimensionEnum
    public var startIndex: Int
    public var endIndex: Int

    public init(sheetId: Int, dimension: DimensionEnum, startIndex: Int, endIndex: Int) {
        self.sheetId = sheetId
        self.dimension = dimension
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}
