//
//  NaverMapStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import NMapsMap

struct NaverMapStore: ReducerProtocol {
    struct State: Equatable {
        let beachList: [Beach]
        let locations: [NMGLatLng]
        
        init(beachList: [Beach]) {
            self.beachList = beachList
            self.locations = beachList.map(\.location)
        }
    }
    
    enum Action: Equatable {
        case selectBeach(Int)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectBeach:
                return .none
            }
        }
    }
}
