//
//  MainStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct MainStore: ReducerProtocol {
    struct State: Equatable {
        var selectedTab = Tab.mySea
        var photoListState = PhotoFolderStore.State()
        var mapState = BeachMapStore.State()
        
        enum Tab {
            case mySea
            case map
        }
    }
    
    enum Action: Equatable {
        // User Action
        case selectedTab(MainStore.State.Tab)
        
        case photoListAction(PhotoFolderStore.Action)
        case mapAction(BeachMapStore.Action)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectedTab(let tab):
                state.selectedTab = tab
                return .none
                
            default:
                return .none
            }
        }
        
        Scope(state: \.photoListState, action: /Action.photoListAction) {
            PhotoFolderStore()
        }
        
        Scope(state: \.mapState, action: /Action.mapAction) {
            BeachMapStore()
        }
    }
}
