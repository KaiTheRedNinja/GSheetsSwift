// The Swift Programming Language
// https://docs.swift.org/swift-book

/// A namespace for the Google Sheets API
public enum GSheetsSwiftAPI: GSheetsSwiftAPIProtocol {
    /// The API surface for spreadsheet API requests
    public enum ATSpreadsheets: GSheetsSwiftAPIProtocol {}
}

/// An empty protocol that represents an API
public protocol GSheetsSwiftAPIProtocol {}

/// A Codable-like protocol, where values are encoded into key value pairs of `[String: String]`
///
/// Used for the query parameters of API requests
public protocol StringCodable {
    /// The String dictionary encoded representation of the value
    func stringDictionaryEncoded() -> [String: String]
}

/// An empty struct, used to represent the lack of a query, body, or response data in an API request
public struct VoidStringCodable: StringCodable, Codable {
    public init() {}
    public func stringDictionaryEncoded() -> [String : String] { [:] }
}
