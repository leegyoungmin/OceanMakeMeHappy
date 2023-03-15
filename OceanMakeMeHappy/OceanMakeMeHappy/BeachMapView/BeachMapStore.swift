//
//  BeachMapStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import NMapsMap

struct BeachMapStore: ReducerProtocol {
    struct State: Equatable {
        let beachList: [Beach]
        let locations: [NMGLatLng]
        var selectedIndex: Int = 0
        
        init(beachList: [Beach], selectedIndex: Int) {
            self.beachList = beachList
            self.locations = beachList.map { $0.location }
            self.selectedIndex = selectedIndex
        }
    }
    
    enum Action: Equatable {
        // User Action
        case selectBeach(index: Int)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .selectBeach(index):
                state.selectedIndex = index
                return .none
            }
        }
    }
}
