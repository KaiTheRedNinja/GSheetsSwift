// The Swift Programming Language
// https://docs.swift.org/swift-book

public enum GSheetsSwiftAPI: GSheetsSwiftAPIProtocol {
    public enum ATSpreadsheets: GSheetsSwiftAPIProtocol {}
}

public protocol GSheetsSwiftAPIProtocol {}

/// Like Codable but to `[String: String]`
public protocol StringCodable {
    func stringDictionaryEncoded() -> [String: String]
}

public struct VoidStringCodable: StringCodable, Codable {
    public init() {}
    public func stringDictionaryEncoded() -> [String : String] { [:] }
}
