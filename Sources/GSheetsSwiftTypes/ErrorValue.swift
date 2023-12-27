//
//  ErrorValue.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct ErrorValue: Codable, Equatable {
    
    public static func == (lhs: ErrorValue, rhs: ErrorValue) -> Bool {
        return lhs.type == rhs.type && lhs.message == rhs.message
    }
    
    public var type: ErrorType
    public var message: String
}
