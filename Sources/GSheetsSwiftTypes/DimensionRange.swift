//
//  DimensionRange.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// The range of a dimension
public struct DimensionRange: Codable {
    /// The id of the sheet page it belongs to
    public var sheetId: Int
    /// The direction that the dimension is facing
    public var dimension: DimensionEnum
    /// The start column or row
    public var startIndex: Int
    /// The end column or row
    public var endIndex: Int
    
    /// Creates a dimension range
    /// - Parameters:
    ///   - sheetId: The id of the sheet page it belongs to
    ///   - dimension: The direction that the dimension is facing
    ///   - startIndex: The start column or row
    ///   - endIndex: The end column or row
    public init(sheetId: Int, dimension: DimensionEnum, startIndex: Int, endIndex: Int) {
        self.sheetId = sheetId
        self.dimension = dimension
        self.startIndex = startIndex
        self.endIndex = endIndex
    }
}
