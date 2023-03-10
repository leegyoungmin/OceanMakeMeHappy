//
//  WebRepository.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation

protocol WebRepository {
    var session: URLSession { get }
    var baseURL: String { get }
}

protocol APICall {
    var path: String { get }
    var method: String { get }
    var queries: [String: String]? { get }
    var headers: [String: String]? { get }
}

enum APIError: Error {
    case invalidURL
    case httpCode(Int)
    case unExpectedResponse
    case imageDeserialization
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "잘못된 URL 요청입니다."
        case .httpCode(let httpCode):
            return "잘못된 ResponseCode가 발생하였습니다. \(httpCode)"
        case .unExpectedResponse:
            return "서버의 문제가 발생하였습니다."
        case .imageDeserialization:
            return "Data를 Image로 변경하는데 문제가 발생하였습니다."
        }
    }
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard var components = URLComponents(string: baseURL) else {
            throw APIError.invalidURL
        }
        
        if let queries = queries {
            components.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = components.url else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }
}

extension WebRepository {
    func load<Value: Decodable>(endPoint: APICall) -> AnyPublisher<Value, Error> {
        guard let request = try? endPoint.urlRequest(baseURL: baseURL) else {
            return Fail<Value, Error>(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: request)
            .tryMap { (data, response) in
                guard let code = (response as? HTTPURLResponse)?.statusCode else {
                    throw APIError.unExpectedResponse
                }
                guard (200...300) ~= code else {
                    throw APIError.httpCode(code)
                }
                return data
            }
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
