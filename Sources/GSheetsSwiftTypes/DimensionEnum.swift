//
//  DimensionEnum.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public enum DimensionEnum: String, Codable { // not called Dimension since it's a keyword
    case dimension_unspecified = "DIMENSION_UNSPECIFIED"
    case rows = "ROWS"
    case columns = "COLUMNS"
}
