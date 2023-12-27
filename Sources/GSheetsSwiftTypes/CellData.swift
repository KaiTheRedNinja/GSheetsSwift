//
//  CellData.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct CellData: Codable, Equatable {
    
    public static func == (lhs: CellData, rhs: CellData) -> Bool {
        return lhs.effectiveValue == rhs.effectiveValue && lhs.formattedValue == rhs.formattedValue && lhs.userEnteredValue == rhs.userEnteredValue
    }
    
    public var userEnteredValue: ExtendedValue?
    public var effectiveValue: ExtendedValue?
    public var formattedValue: String?

    public init(userEnteredValue: ExtendedValue? = nil,
                effectiveValue: ExtendedValue? = nil,
                formattedValue: String? = nil) {
        self.userEnteredValue = userEnteredValue
        self.effectiveValue = effectiveValue
        self.formattedValue = formattedValue
    }
}
