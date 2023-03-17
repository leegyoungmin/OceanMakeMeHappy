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
        var selectedIndex: Int = 0
        
        var mapStore: NaverMapStore.State?
        var selectedPreviewBeachState: BeachPreviewCardStore.State?
        var selectedInformationState: BeachInformationStore.State?
        
        var isPresentInformationView: Bool = false
    }
    
    enum Action: Equatable {
        case onAppear
        
        // Child Action
        case mapStore(NaverMapStore.Action)
        case previewCardAction(BeachPreviewCardStore.Action)
        case informationAction(BeachInformationStore.Action)
        
        // Inner Action
        case _loadLocalResponse(TaskResult<[Beach]>)
        case _setPresentState(Bool)
    }
    
    @Dependency(\.beachClient) var beachClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .task {
                    await ._loadLocalResponse(
                        TaskResult { try await self.beachClient.loadBeachList() }
                    )
                }
            case let ._loadLocalResponse(.success(response)):
                state.beachList = response
                state.mapStore = NaverMapStore.State(beachList: response)
                state.selectedPreviewBeachState = BeachPreviewCardStore.State(
                    beach: response[state.selectedIndex]
                )
                return .none
                
            case ._loadLocalResponse(.failure):
                return .none
                
            case .mapStore(.selectBeach(let index)):
                state.selectedIndex = index - 1
                let beach = state.beachList[state.selectedIndex]
                state.selectedPreviewBeachState = BeachPreviewCardStore.State(beach: beach)
                return .none
                
            case .mapStore:
                return .none
                
            case .previewCardAction(.tapMoreButton):
                let beach = state.beachList[state.selectedIndex]
                state.selectedInformationState = BeachInformationStore.State(beach: beach)
                return .task {
                    return ._setPresentState(true)
                }
                
            case ._setPresentState(let isPresent):
                state.isPresentInformationView = isPresent
                return .none
                
            case .previewCardAction:
                return .none
                
            case .informationAction:
                return .none
            }
        }
        .ifLet(\.mapStore, action: /Action.mapStore) {
            NaverMapStore()
        }
        .ifLet(\.selectedPreviewBeachState, action: /Action.previewCardAction) {
            BeachPreviewCardStore()
                ._printChanges()
        }
        .ifLet(\.selectedInformationState, action: /Action.informationAction) {
            BeachInformationStore()
        }
    }
}
