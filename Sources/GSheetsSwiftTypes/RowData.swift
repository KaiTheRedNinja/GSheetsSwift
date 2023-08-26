//
//  RowData.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

public struct RowData: Codable {
    public var values: [CellData]

    public init(values: [CellData]) {
        self.values = values
    }
}
