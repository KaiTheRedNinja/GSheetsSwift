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

    /// Represents a spreadsheet ID, found in the google sheet's link
    ///
    /// `https://docs.google.com/spreadsheets/d/[ID IS HERE]/edit`
    public struct SpreadsheetIdPathParameters: StringCodable {
        var spreadsheetId: String

        public init(spreadsheetId: String) {
            self.spreadsheetId = spreadsheetId
        }

        public func stringDictionaryEncoded() -> [String : String] {
            ["spreadsheetId": spreadsheetId]
        }
    }

    /// Represents a GET query to obtaining a sheet
    public struct GettableQueryParameters: StringCodable {
        /// Ranges to include
        var ranges: String?
        /// Whether metadata should be included
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

    /// Represents an UPDATE request to edit a sheet
    public struct UpdatableRequestData: Codable {
        /// The update requests
        var requests: [UpdateRequest]
        /// Whether the updated spreadsheet should be included in the response
        var includeSpreadsheetInResponse: Bool
        /// The ranges of the response
        var responseRanges: [String]
        /// If the response should include metadata
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

    /// Represents the response to an UPDATE request
    public struct UpdatableResponseData: Codable {
        /// The ID of the spreadsheet
        public var spreadsheetId: String
        /// The updated spreadsheet instance, if requested
        public var updatedSpreadsheet: Spreadsheet?
    }
}
