//
//  CellData.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// Represents the data within a cell
public struct CellData: Codable, Equatable {
    public static func == (lhs: CellData, rhs: CellData) -> Bool {
        return lhs.effectiveValue == rhs.effectiveValue && lhs.formattedValue == rhs.formattedValue && lhs.userEnteredValue == rhs.userEnteredValue
    }
    
    /// The user entered value, which the user can edit
    public var userEnteredValue: ExtendedValue?
    /// The effective value, which the cell displays. For example, the result of a formula.
    public var effectiveValue: ExtendedValue?
    /// The value as a string
    public var formattedValue: String?
    
    /// Creates a cell data instance
    /// - Parameters:
    ///   - userEnteredValue: The user entered value, which the user can edit
    ///   - effectiveValue: The effective value, which the cell displays. For example, the result of a formula.
    ///   - formattedValue: The value as a string
    public init(userEnteredValue: ExtendedValue? = nil,
                effectiveValue: ExtendedValue? = nil,
                formattedValue: String? = nil) {
        self.userEnteredValue = userEnteredValue
        self.effectiveValue = effectiveValue
        self.formattedValue = formattedValue
    }
}
