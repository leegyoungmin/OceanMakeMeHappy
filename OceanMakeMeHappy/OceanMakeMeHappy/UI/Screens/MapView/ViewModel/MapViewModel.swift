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
    @Published var isPresentDetail: Bool = false
    @Published var detailBeach: Beach?
    @Published var detailInformation: BeachInformation?
    
    var locations: [NMGLatLng] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        guard let beachList: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") else { return }
        
        self.beachList = beachList.items
        self.locations = beachList.items.map { $0.location }
    }
    
    func selectDetailItem(with information: BeachInformation?) {
        self.detailBeach = beachList[selectedIndex - 1]
        self.detailInformation = information
    }
}
