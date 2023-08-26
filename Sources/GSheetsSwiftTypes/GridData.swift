//
//  GridData.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct GridData: Codable {
    public var startRow: Int?
    public var startColumn: Int?
    public var rowData: [RowData]
//    public var rowMetadata: [DimensionProperties]
//    public var columnMetadata: [DimensionProperties]
}
