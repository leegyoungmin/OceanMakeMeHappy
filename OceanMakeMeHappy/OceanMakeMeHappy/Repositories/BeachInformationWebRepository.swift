//
//  BeachInformationWebRepository.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation

protocol BeachInformationWebRepository: WebRepository {
    func loadInformation(contentId: String) -> AnyPublisher<BeachInformationResponse, Error>
}

struct RealBeachInformationWebRepository: BeachInformationWebRepository {
    var session: URLSession
    var baseURL: String
    
    init(session: URLSession = URLSession.shared, baseURL: String = "http://api.visitjeju.net") {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadInformation(contentId: String) -> AnyPublisher<BeachInformationResponse, Error> {
        return load(endPoint: API.beachInformation(contentId))
    }
}

extension RealBeachInformationWebRepository {
    enum API {
        case beachInformation(String)
    }
}

extension RealBeachInformationWebRepository.API: APICall {
    var path: String {
        switch self {
        case .beachInformation(_):
            return "/vsjApi/contents/searchList"
        }
    }
    
    var method: String {
        switch self {
        case .beachInformation(_):
            return "Get"
        }
    }
    
    var queries: [String : String]? {
        switch self {
        case .beachInformation(let contentId):
            return [
                "apiKey": "4skn9eunxf928kqd",
                "locale": "kr",
                "category": "c1",
                "page": "1",
                "cid": contentId
            ]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .beachInformation(_):
            return nil
        }
    }
}
