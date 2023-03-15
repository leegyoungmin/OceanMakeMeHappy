//
//  BeachPreviewCardStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct BeachPreviewCardStore: ReducerProtocol {
    struct State: Equatable {
        let beach: Beach
        var information: BeachInformation?
    }
    
    enum Action: Equatable {
        // Inner Action
        case _requestInformation
        case _requestResponse(TaskResult<BeachInformation>)
    }
    
    @Dependency(\.beachInformationClient) var beachInformationClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case ._requestInformation:
                return .task { [contentId = state.beach.contentId] in
                    await ._requestResponse(
                        TaskResult { try await self.beachInformationClient.request(contentId) }
                    )
                }
                
            case let ._requestResponse(.success(response)):
                state.information = response
                return .none
                
            case ._requestResponse(.failure):
                state.information = nil
                return .none
            }
        }
    }
}
