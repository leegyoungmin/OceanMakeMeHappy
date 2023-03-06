//
//  APICall.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queries: [String: String]? { get }
    func body() throws -> Data?
}

enum APIError: Error {
    case invalidURL
    case httpCode
    case unExpectedResponse
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "유효하지 않은 URL입니다."
        case .httpCode:
            return "잘못된 요청입니다."
        case .unExpectedResponse:
            return "서버로 부터 잘못된 응답입니다."
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard var component = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        
        component.path = path
        
        if let queries = queries {
            component.queryItems = queries.queries()
        }

        guard let url = component.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }
}

extension Dictionary where Key == String, Value == String {
    func queries() -> [URLQueryItem] {
        return self.map { .init(name: $0.key, value: $0.value) }
    }
}
