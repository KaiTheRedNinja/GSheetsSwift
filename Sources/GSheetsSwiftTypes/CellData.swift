//
//  CellData.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct CellData: Codable {
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
