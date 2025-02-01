//
//  APIConstants.swift
//  Headway
//
//  Created by omar abozeid on 22/01/2025.
//

import Foundation

// Building Part

final class APIConstants {
    static let baseURL = "https://tenor.googleapis.com/v2"
    static let apiKey = "AIzaSyDp3xxLkxeQKEG3XfmJJ7Qs1vS0whELSNs"
    static let clientKey = "762372497923-lbo0ejaarl7i6tfmadlpjljtif47vl1k.apps.googleusercontent.com"
}
enum HTTPHeaderField: String {
    case authentication = "Authentication"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case authorization = "Authorization"
    case acceptLanguage = "Accept-Language"
    case userAgent = "User-Agent"
}
enum ContentType: String {
    case json = "application/json"
    case xwwwformurlencoded = "application/x-www-form-urlencoded"
}
