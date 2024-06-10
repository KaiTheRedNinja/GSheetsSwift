//
//  APICaller.swift
//  
//
//  Created by Kai Quan Tay on 11/5/23.
//

import Foundation
import SwiftUI
import GSheetsSwiftTypes

/// Wraps an OAuth access token, used to authenticate API calls.
///
/// To obtain an OAuth access token, see [the Google docs](https://developers.google.com/identity/sign-in/ios/start-integrating)
public enum APISecretManager {
    /// The Google OAuth access token.
    ///
    /// The access token must have access to at least one of the following scopes, for read-write support:
    /// - https://www.googleapis.com/auth/drive
    /// - https://www.googleapis.com/auth/drive.file
    /// - https://www.googleapis.com/auth/spreadsheets
    ///
    /// Or either of these scopes for read-only support:
    /// - https://www.googleapis.com/auth/drive.readonly
    /// - https://www.googleapis.com/auth/spreadsheets.readonly
    public static var accessToken: String = ""
}

/// Facilitates the sending and receiving of a request
enum APICaller<ResponseData: Decodable> {
    /// Does an API request
    ///
    /// Usage:
    /// ```
    /// APICaller.request(urlString: "https://your/url/here",
    ///                   httpMethod: "POST",
    ///                   responseType: String.self) { result in
    ///     // handle the result here
    /// }
    /// ```
    /// - Parameters:
    ///   - urlString: The url to request, with path parameters as `{name}` placeholders
    ///   - httpMethod: The HTTP method to use, eg. `GET`, `POST`
    ///   - pathParameters: The path parameters in the URL. Empty by default.
    ///   - queryParameters: The query parameters in the URL (stuff after the ? sign). Empty by default.
    ///   - requestData: The request body, Codable. Empty by default.
    ///   - responseType: The type to decode the response to
    ///   - callback: A callback, called when this method succeeds or fails.
    static func request(
        urlString: String,
        httpMethod: String,
        pathParameters: [String: String] = [:],
        queryParameters: [String: String] = [:],
        requestData: (any Encodable)? = nil,
        responseType: ResponseData.Type,
        callback: @escaping (Result<ResponseData, Error>) -> Void
    ) {
        var filledURL = urlString

        // Replace the url path parameters
        for pathParameter in pathParameters {
            filledURL = filledURL.replacingOccurrences(of: "{\(pathParameter.key)}", with: pathParameter.value)
        }

        // put the query parameters at the end
        filledURL.append("?")
        var mutableQueryParameters = queryParameters
        mutableQueryParameters["access_token"] = APISecretManager.accessToken
        for queryParameter in mutableQueryParameters {
            filledURL.append("\(queryParameter.key)=\(queryParameter.value)&")
        }

        // If there are any empty path parameters, return nil
        if filledURL.contains("/{\\w+}/") {
            print("Filled url contains placeholder: \(filledURL)")
            callback(.failure(NSError(domain: "Filled url contains placeholder: \(filledURL)",
                                      code: 1)))
            return
        }

        // create the URL
        guard let url = URL(string: filledURL) else {
            print("Failed to create url: \(filledURL)")
            callback(.failure(NSError(domain: "Failed to create url: \(filledURL)",
                                      code: 2)))
            return
        }

        // set up the request
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let requestData,
           let encodedBody = try? JSONEncoder().encode(requestData),
           String(data: encodedBody, encoding: .utf8) != "{}" {
            request.httpBody = encodedBody
        }

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if let data {
                do {
                    if ResponseData.self == VoidStringCodable.self,
                       let decodedString = String(data: data, encoding: .utf8),
                       decodedString != "{}" {
                        print("Expected \"{}\", recieved \"\(decodedString)\"")
                    }
                    let result = try JSONDecoder().decode(ResponseData.self, from: data)
                    callback(.success(result))
                } catch {
                    print("""
Decoding error: \(error)
Failure Data: \(String(data: data, encoding: .utf8) ?? "undecodable")
""")
                    callback(.failure(error))
                }
            } else if let error {
                callback(.failure(error))
            }
        })

        task.resume()
    }
}

public extension GSheetsSwiftGettable {
    /// Provides a HTTP `GET` API
    static func get(
        params: GetPathParameters,
        query: GetQueryParameters,
        data: GetRequestData,
        completion: @escaping (Result<GetResponseData, Error>) -> Void
    ) {
        APICaller.request(urlString: apiGettable,
                          httpMethod: "GET",
                          pathParameters: params.stringDictionaryEncoded(),
                          queryParameters: query.stringDictionaryEncoded(),
                          requestData: data,
                          responseType: GetResponseData.self,
                          callback: completion)
    }
}

public extension GSheetsSwiftUpdatable {
    /// Provides a HTTP `UPDATE` API
    static func update(
        params: UpdatePathParameters,
        query: UpdateQueryParameters,
        data: UpdateRequestData,
        completion: @escaping (Result<UpdateResponseData, Error>) -> Void
    ) {
        APICaller.request(urlString: apiUpdatable,
                          httpMethod: "POST",
                          pathParameters: params.stringDictionaryEncoded(),
                          queryParameters: query.stringDictionaryEncoded(),
                          requestData: data,
                          responseType: UpdateResponseData.self,
                          callback: completion)
    }
}
