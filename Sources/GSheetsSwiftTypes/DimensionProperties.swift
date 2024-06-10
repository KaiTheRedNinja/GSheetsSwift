//
//  DimensionProperties.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// Represents the properties of a region
public struct DimensionProperties: Codable {
    /// Whether the region is hidden by a filter
    public var hiddenByFilter: Bool?
    /// Whether the region is hidden by the user
    public var hiddenByUser: Bool?
    /// The pixel size of the row or column
    public var pixelSize: Int?
    /// Developer metadata
    public var developerMetadata: [DeveloperMetadata]?
    /// The name of the region
    public var dataSourceColumnReference: DataSourceColumnReference?
}
