//
//  Sheet.swift
//
//
//  Created by Tristan Chay on 4/7/23.
//

import Foundation

public struct Sheet: Codable {
    public var properties: SheetProperties
    public var data: [GridData]
}
