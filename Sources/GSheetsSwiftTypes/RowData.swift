//
//  RowData.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

public struct RowData: Codable, Equatable {
    public static func == (lhs: RowData, rhs: RowData) -> Bool {
        return lhs.values == rhs.values
    }
    
    public var values: [CellData]

    public init(values: [CellData]) {
        self.values = values
    }
}
