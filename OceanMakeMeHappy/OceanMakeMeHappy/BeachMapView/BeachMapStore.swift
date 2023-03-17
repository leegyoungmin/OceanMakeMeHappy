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
        var selectedPreviewBeachState: BeachPreviewCardStore.State?
        var selectedIndex: Int = 0
    }
    
    enum Action: Equatable {
        case onAppear
        case mapStore(NaverMapStore.Action)
        case previewCardAction(BeachPreviewCardStore.Action)
        
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
            case let .loadLocalResponse(.success(response)):
                state.beachList = response
                state.mapStore = NaverMapStore.State(beachList: response)
                state.selectedPreviewBeachState = BeachPreviewCardStore.State(beach: response[0])
                return .none
                
            case .loadLocalResponse(.failure):
                return .none
                
                
            case .mapStore(.selectBeach(let index)):
                state.selectedIndex = index - 1
                let beach = state.beachList[state.selectedIndex]
                state.selectedPreviewBeachState = BeachPreviewCardStore.State(beach: beach)
                return .none
                
            case .mapStore:
                return .none
                
            case .previewCardAction:
                return .none
            }
        }
        .ifLet(\.mapStore, action: /Action.mapStore) {
            NaverMapStore()
        }
        .ifLet(\.selectedPreviewBeachState, action: /Action.previewCardAction) {
            BeachPreviewCardStore()
        }
    }
}
