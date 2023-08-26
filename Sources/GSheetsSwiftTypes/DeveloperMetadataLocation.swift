//
//  DeveloperMetadataLocation.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct DeveloperMetadataLocation: Codable {
    public var locationType: DeveloperMetadataLocationType
    public var spreadsheet: Bool
    public var sheetId: Int
    public var dimensionRange: DimensionRange
}
