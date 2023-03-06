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

extension WebRepository {
    func load<Value: Decodable>(endPoint: APICall) -> AnyPublisher<Value, Error> {
        do {
            let request = try endPoint.urlRequest(baseURL: baseURL)
            return session
                .dataTaskPublisher(for: request)
                .tryMap {
                    guard let statusCode = ($0.1 as? HTTPURLResponse)?.statusCode,
                          (200..<300) ~= statusCode  else {
                        throw APIError.unExpectedResponse
                    }
                    
                    return $0.0
                }
                .decode(type: Value.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
            
        } catch let error {
            return Fail<Value, Error>(error: error)
                .eraseToAnyPublisher()
        }
    }
}
