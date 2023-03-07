//
//  MapViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import NMapsMap

final class MapViewModel: ObservableObject {
    @Published var beachList = [Beach]()
    var locations: [NMGLatLng] = []
    
    init() {
        if let beachList: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") {
            self.beachList = beachList.items
            self.locations = beachList.items.map { $0.location }
        }
    }
}
