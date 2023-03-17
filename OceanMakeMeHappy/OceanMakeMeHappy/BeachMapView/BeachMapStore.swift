//
//  BeachMapStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import NMapsMap

struct BeachMapStore: ReducerProtocol {
    struct State: Equatable {
        var beachList: [Beach] = []
        var mapStore: NaverMapStore.State?
        var selectedIndex: Int = 1
    }
    
    enum Action: Equatable {
        case onAppear
        case mapStore(NaverMapStore.Action)
        
        // Inner Action
        case loadLocalResponse(TaskResult<[Beach]>)
    }
    
    @Dependency(\.beachClient) var beachClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .task {
                    await .loadLocalResponse(
                        TaskResult { try await self.beachClient.loadBeachList() }
                    )
                }
            case .mapStore(.selectBeach(let index)):
                state.selectedIndex = index
                return .none
                
            case let .loadLocalResponse(.success(response)):
                state.beachList = response
                state.mapStore = NaverMapStore.State(beachList: response)
                return .none
                
            case .loadLocalResponse(.failure):
                return .none
            }
        }
        .ifLet(\.mapStore, action: /Action.mapStore) {
            NaverMapStore()
        }
    }
}
