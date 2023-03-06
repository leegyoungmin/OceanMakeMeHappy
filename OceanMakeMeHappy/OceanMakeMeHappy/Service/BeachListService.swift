//
//  BeachListService.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

protocol BeachService {
    func load() -> AnyPublisher<[Beach], Error>
}

class BeachListService: BeachService {
    var subscribers = Set<AnyCancellable>()
    let webRepository: BeachListWebRepository
    
    init(webRepository: BeachListWebRepository) {
        self.webRepository = webRepository
    }
    
    func load() -> AnyPublisher<[Beach], Error> {
        return webRepository
            .loadBeaches()
            .map { $0.items }
            .eraseToAnyPublisher()
    }
}
