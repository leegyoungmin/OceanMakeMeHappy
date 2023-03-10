//
//  MapViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import NMapsMap

final class MapViewModel: ObservableObject {
    @Published var beachList = [Beach]()
    @Published var selectedIndex: Int = 1
    var locations: [NMGLatLng] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        guard let beachList: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") else { return }
        
        self.beachList = beachList.items
        self.locations = beachList.items.map { $0.location }
        
        RealBeachInformationWebRepository(contentId: "CONT_000000000500083").loadInformation()
            .sink { completion in
                switch completion {
                case .finished:
                    print("Finished API Call")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { information in
                print(information)
            }
            .store(in: &cancellables)

    }
}

extension MapViewModel {
    
}
