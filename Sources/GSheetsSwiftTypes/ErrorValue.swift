//
//  ErrorValue.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

/// Errors that can occur in a cell due to a formula, with detailed messages
public struct ErrorValue: Codable, Equatable {
    public static func == (lhs: ErrorValue, rhs: ErrorValue) -> Bool {
        return lhs.type == rhs.type && lhs.message == rhs.message
    }
    
    /// The type of error
    public var type: ErrorType
    /// The details of the error
    public var message: String
}
