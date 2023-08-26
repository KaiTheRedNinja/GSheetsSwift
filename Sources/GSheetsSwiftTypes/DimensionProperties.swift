//
//  DimensionProperties.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct DimensionProperties: Codable {
    public var hiddenByFilter: Bool?
    public var hiddenByUser: Bool?
    public var pixelSize: Int?
    public var developerMetadata: [DeveloperMetadata]?
    public var dataSourceColumnReference: DataSourceColumnReference?
}
