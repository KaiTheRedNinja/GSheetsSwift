//
//  SheetProperties.swift
//
//
//  Created by Kai Quan Tay on 5/7/23.
//

import Foundation

/// The properties of a ``Sheet``
public struct SheetProperties: Codable, Equatable {
    /// The ID of the sheet page
    public var sheetId: Int
    /// The name of the sheet page
    public var title: String
    /// The index of the sheet page
    public var index: Int
}
