//
//  DeveloperMetadata.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct DeveloperMetadata: Codable {
    public var metadataId: Int
    public var metadataKey: String
    public var metadataValue: String
    public var location: DeveloperMetadataLocation
    public var visibility: DeveloperMetadataVisibility
}
