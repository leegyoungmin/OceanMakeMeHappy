//
//  MapViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class MapViewModel: ObservableObject {
    private let webService: BeachService
    private var subscribers = Set<AnyCancellable>()
    
    init(webService: BeachService) {
        self.webService = webService
        
        webService.load()
            .sink { error in
                print(error)
            } receiveValue: { datas in
                print(datas)
            }
            .store(in: &subscribers)

    }
}
