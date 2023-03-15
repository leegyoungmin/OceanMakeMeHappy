//
//  BeachInformationService.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation

protocol BeachInformationService {
    func loadBeachInformation(contentId: String) -> AnyPublisher<BeachInformation?, Error>
}

struct RealBeachInformationService: BeachInformationService {
    let webService: BeachInformationWebRepository
    
    init(webService: BeachInformationWebRepository) {
        self.webService = webService
    }
    
    func loadBeachInformation(contentId: String) -> AnyPublisher<BeachInformation?, Error> {
        webService.loadInformation(contentId: contentId)
            .compactMap { $0.beachInformation }
            .eraseToAnyPublisher()
    }
}
