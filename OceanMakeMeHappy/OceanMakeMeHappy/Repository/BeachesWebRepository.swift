//
//  BeachesWebRepository.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation

protocol BeachWebRepository: WebRepository {
    func loadBeaches() -> AnyPublisher<[Beach], Error>
}

struct BeachListWebRepository: BeachWebRepository {
    var session: URLSession
    var baseURL: String
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadBeaches() -> AnyPublisher<[Beach], Error> {
        return load(endPoint: API.allBeaches)
    }
    
    
}


extension BeachListWebRepository {
    enum API {
        case allBeaches
    }
}

extension BeachListWebRepository.API: APICall {
    var queries: [String : String]? {
        switch self {
        case .allBeaches:
            return [
                "ServiceKey": "fNF57A6/dZZtGoxp9uTDfVjCQNAvKcuopT35EvbFrxJBvOiHVNgZ9tzux9EvsZEsJTHNV78yj/PuVA5c7vbHSQ==",
                "SIDO_NM": "제주",
                "resultType": "json"
            ]
        }
    }
    
    var path: String {
        switch self {
        case .allBeaches:
            return "/1192000/service/OceansBeachInfoService1/getOceansBeachInfo1"
        }
    }

    var method: String {
        return "Get"
    }
    
    var headers: [String : String]? {
        switch self {
        case .allBeaches:
            return nil
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
    
}
