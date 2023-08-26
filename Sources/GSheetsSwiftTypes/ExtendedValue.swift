//
//  ExtendedValue.swift
//  
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct ExtendedValue: Codable {
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
