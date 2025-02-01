//
//  NetworkRequest.swift
//  Headway
//
//  Created by omar abozeid on 22/01/2025.
//

import Foundation

// Request Method
enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

// Network Request Errors
enum NetworkRequestError: LocalizedError, Equatable {
    case businessError(_ description: String)
    case urlSessionFailed(_ error: URLError)
    case timeOut
    case noInternet
    case decodingError(_ description: String)
    case error5xx(_ code: Int)
    case unknownError
}

// Request Protocol
protocol Request {
    var path: String { get }
    var fullPath: String? { get }
    var method: RequestMethod { get }
    var contentType: String { get }
    var body: [String: Any]? { get }
    var bodyData: Data? { get }
    var queryParams: [String: Any]? { get }
    var headers: [String: String]? { get }
    func createCommonHeaders(shouldHaveAuthorization: Bool) -> [String: String]?
}

// Request Defaults and Helpers
extension Request {
    
    var method: RequestMethod { return .get }
    var contentType: String { return "application/json" }
    var fullPath: String? { return nil }
    var queryParams: [String: Any]? { return nil }
    var body: [String: Any]? { return nil }
    var bodyData: Data? { return nil }
    
    var headers: [String: String]? { return createCommonHeaders(shouldHaveAuthorization: true) }
    
    func createCommonHeaders(shouldHaveAuthorization: Bool) -> [String: String]? {
        var headers = [
            "Content-Type": "application/json",
            "Accept-Language": "en"
        ]
        
        if shouldHaveAuthorization, let token = UserDefaults.standard.string(forKey: "authToken") {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    /// ✅ Converts HTTP Dictionary to JSON Data
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        return try? JSONSerialization.data(withJSONObject: params, options: [])
    }
    
    private func constructUrl(baseURL: String) -> URL? {
        if let fullPath = fullPath, let url = URL(string: fullPath) {
            return url
        }
        
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path.append(path)
        urlComponents.queryItems = addQueryItems(queryParams: queryParams)
        
        return urlComponents.url
    }
    
    func addQueryItems(queryParams: [String: Any]?) -> [URLQueryItem]? {
        guard let queryParams = queryParams else { return nil }
        return queryParams.compactMap { key, value in
            guard let value = value as? CustomStringConvertible else { return nil }
            return URLQueryItem(name: key, value: value.description)
        }
    }
    
    func asURLRequest(baseURL: String) -> URLRequest? {
        guard let finalURL = constructUrl(baseURL: baseURL) else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = bodyData ?? requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 30
        
        print("🔗 Final Request URL: \(finalURL.absoluteString)")
        
        return request
    }
}
