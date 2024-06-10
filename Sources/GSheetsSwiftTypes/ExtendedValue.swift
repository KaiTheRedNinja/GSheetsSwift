//
//  ExtendedValue.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// A value that a cell can contain
///
/// Out of the following properties, only one should be populated:
///  - `numberValue`
///  - `stringValue`
///  - `boolValue`
///  - `formulaValue`
///  - `errorValue`
public struct ExtendedValue: Codable, Equatable {
    
    public static func == (lhs: ExtendedValue, rhs: ExtendedValue) -> Bool {
        return lhs.numberValue == rhs.numberValue && lhs.stringValue == rhs.stringValue && lhs.boolValue == rhs.boolValue && lhs.formulaValue == rhs.formulaValue && lhs.errorValue == rhs.errorValue
    }
    
    /// The number value, if any
    public var numberValue: Double?
    /// The string value, if any
    public var stringValue: String?
    /// The bool value, if any
    public var boolValue: Bool?
    /// The formula value, if any
    public var formulaValue: String?
    /// The error value, if any
    public var errorValue: ErrorValue?
    
    /// Creates an extended value. You should specify EXACTLY ONE of these attributes.
    /// - Parameters:
    ///   - numberValue: The number value, if any
    ///   - stringValue: The string value, if any
    ///   - boolValue: The bool value, if any
    ///   - formulaValue: The formula value, if any
    ///   - errorValue: The error value, if any
    public init(numberValue: Double? = nil,
                stringValue: String? = nil,
                boolValue: Bool? = nil,
                formulaValue: String? = nil,
                errorValue: ErrorValue? = nil) {
        self.numberValue = numberValue
        self.stringValue = stringValue
        self.boolValue = boolValue
        self.formulaValue = formulaValue
        self.errorValue = errorValue
    }
}
