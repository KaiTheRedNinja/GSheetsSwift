//
//  DimensionEnum.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// The direction that a dimension is facing
public enum DimensionEnum: String, Codable { // not called Dimension since it's a keyword
    /// The dimension is unspecified
    case dimension_unspecified = "DIMENSION_UNSPECIFIED"
    /// The dimension is referring to rows
    case rows = "ROWS"
    /// The dimension is referring to columns
    case columns = "COLUMNS"
}
