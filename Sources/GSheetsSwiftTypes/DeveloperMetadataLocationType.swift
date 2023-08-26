//
//  DeveloperMetadataLocationType.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public enum DeveloperMetadataLocationType: String, Codable {
    case developer_metadata_location_type_unspecified = "DEVELOPER_METADATA_LOCATION_TYPE_UNSPECIFIED"
    case row = "ROW"
    case column = "COLUMN"
    case sheet = "SHEET"
    case spreadsheet = "SPREADSHEET"
}
