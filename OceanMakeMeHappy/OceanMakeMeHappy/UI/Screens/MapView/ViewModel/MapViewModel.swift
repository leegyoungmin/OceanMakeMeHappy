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
    
    init() {
        guard let beachList: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") else { return }
        
        self.beachList = beachList.items
        self.locations = beachList.items.map { $0.location }
    }
}

extension MapViewModel {
    
}
