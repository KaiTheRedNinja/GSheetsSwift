//
//  ATSpreadsheets.swift
//  
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation
import GSheetsSwiftTypes

extension GSheetsSwiftAPI.ATSpreadsheets: GSheetsSwiftGettable, GSheetsSwiftUpdatable {
    
    public typealias GetPathParameters = SpreadsheetIdPathParameters

    public typealias GetQueryParameters = GettableQueryParameters

    public typealias GetRequestData = VoidStringCodable

    public typealias GetResponseData = Spreadsheet

    public static var apiGettable: String = "https://sheets.googleapis.com/v4/spreadsheets/{spreadsheetId}"

    public typealias UpdatePathParameters = SpreadsheetIdPathParameters

    public typealias UpdateQueryParameters = VoidStringCodable

    public typealias UpdateRequestData = UpdatableRequestData

    public typealias UpdateResponseData = UpdatableResponseData

    public static var apiUpdatable: String = "https://sheets.googleapis.com/v4/spreadsheets/{spreadsheetId}:batchUpdate"

    public struct SpreadsheetIdPathParameters: StringCodable {
        var spreadsheetId: String

        public init(spreadsheetId: String) {
            self.spreadsheetId = spreadsheetId
        }

        public func stringDictionaryEncoded() -> [String : String] {
            ["spreadsheetId": spreadsheetId]
        }
    }

    public struct GettableQueryParameters: StringCodable {
        var ranges: String?
        var includeGridData: Bool

        public init(ranges: String? = nil, includeGridData: Bool) {
            self.ranges = ranges
            self.includeGridData = includeGridData
        }

        public func stringDictionaryEncoded() -> [String : String] {
            var encoded = ["includeGridData": "\(includeGridData)"]
            if let ranges {
                encoded["ranges"] = ranges
            }
            return encoded
        }
    }

    public struct UpdatableRequestData: Codable {
        var requests: [UpdateRequest]
        var includeSpreadsheetInResponse: Bool
        var responseRanges: [String]
        var responseIncludeGridData: Bool

        public init(requests: [UpdateRequest],
                    includeSpreadsheetInResponse: Bool,
                    responseRanges: [String],
                    responseIncludeGridData: Bool) {
            self.requests = requests
            self.includeSpreadsheetInResponse = includeSpreadsheetInResponse
            self.responseRanges = responseRanges
            self.responseIncludeGridData = responseIncludeGridData
        }
    }

    public struct UpdatableResponseData: Codable {
        public var spreadsheetId: String
        public var updatedSpreadsheet: Spreadsheet?
    }
}
