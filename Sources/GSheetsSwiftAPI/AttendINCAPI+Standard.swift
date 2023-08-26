//
//  GSheetsSwiftAPI+Standard.swift
//
//
//  Created by Kai Quan Tay on 4/7/23.
//

import Foundation

public protocol GSheetsSwiftGettable: GSheetsSwiftAPIProtocol {
    associatedtype GetPathParameters: StringCodable
    associatedtype GetQueryParameters: StringCodable
    associatedtype GetRequestData: Codable
    associatedtype GetResponseData: Decodable
    static var apiGettable: String { get }
    static func get(
        params: GetPathParameters,
        query: GetQueryParameters,
        data: GetRequestData,
        completion: @escaping (Result<GetResponseData, Error>) -> Void
    )
}

public protocol GSheetsSwiftUpdatable: GSheetsSwiftAPIProtocol {
    associatedtype UpdatePathParameters: StringCodable
    associatedtype UpdateQueryParameters: StringCodable
    associatedtype UpdateRequestData: Codable
    associatedtype UpdateResponseData: Decodable
    static var apiUpdatable: String { get }
    static func update(
        params: UpdatePathParameters,
        query: UpdateQueryParameters,
        data: UpdateRequestData,
        completion: @escaping (Result<UpdateResponseData, Error>) -> Void
    )
}
