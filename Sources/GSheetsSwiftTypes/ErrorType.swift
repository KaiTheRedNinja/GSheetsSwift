//
//  ErrorType.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// Errors that can occur in a cell due to a formula
public enum ErrorType: String, Codable, Equatable {
    /// Unspecified error
    case error_type_unspecified = "ERROR_TYPE_UNSPECIFIED"
    /// General error
    case error = "ERROR"
    /// NULL value
    case null_value = "NULL_VALUE"
    /// Zero division
    case divider_by_zero = "DIVIDE_BY_ZERO"
    /// Incompatible value
    case value = "VALUE"
    /// Broken reference
    case ref = "REF"
    /// Broken name
    case name = "NAME"
    /// Broken number
    case num = "NUM"
    /// Not available
    case n_a = "N_A"
    /// Cell is loading
    case loadin = "LOADIN"
}
