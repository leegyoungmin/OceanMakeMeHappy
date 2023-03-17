//
//  BeachInformationStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct BeachInformationStore: ReducerProtocol {
    struct State: Equatable {
        let beach: Beach
        var information: BeachInformation?
        
        var tags: [String] = []
    }
    
    enum Action: Equatable {
        case onAppear
        
        // Inner Action
        case _informationResponse(TaskResult<BeachInformation>)
    }
    
    @Dependency(\.beachInformationClient) var beachInformationClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .task { [id = state.beach.contentId] in
                    await ._informationResponse(
                        TaskResult {
                            try await beachInformationClient.request(id)
                        }
                    )
                }
                
            case let ._informationResponse(.success(information)):
                state.information = information
                state.tags = information.alltag
                return .none
                
            case ._informationResponse(.failure):
                return .none
            }
        }
    }
}
