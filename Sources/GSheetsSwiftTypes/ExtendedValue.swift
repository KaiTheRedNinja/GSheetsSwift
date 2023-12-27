//
//  ExtendedValue.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct ExtendedValue: Codable, Equatable {
    
    public static func == (lhs: ExtendedValue, rhs: ExtendedValue) -> Bool {
        return lhs.numberValue == rhs.numberValue && lhs.stringValue == rhs.stringValue && lhs.boolValue == rhs.boolValue && lhs.formulaValue == rhs.formulaValue && lhs.errorValue == rhs.errorValue
    }
    
    public var numberValue: Double?
    public var stringValue: String?
    public var boolValue: Bool?
    public var formulaValue: String?
    public var errorValue: ErrorValue?

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
