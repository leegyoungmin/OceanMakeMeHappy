//
//  BeachInformationStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BeachInformationStore: ReducerProtocol {
    struct State: Equatable {
        let beach: Beach
        var information: BeachInformation?
        
        var imageData: Data = Data()
    }
    
    enum Action: Equatable {
        case onAppear
        
        // Inner Action
        case _informationResponse(TaskResult<BeachInformation>)
        case _loadImage(TaskResult<Data>)
    }
    
    @Dependency(\.beachInformationClient) var beachInformationClient
    @Dependency(\.imageClient) var imageClient
    
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
                return .task { [path = state.information?.imagePath] in
                    await ._loadImage(
                        TaskResult {
                            try await imageClient.loadImageData(path)
                        }
                    )
                }
                
            case ._informationResponse(.failure):
                return .none
                
            case let ._loadImage(.success(data)):
                state.imageData = data
                return .none
                
            case ._loadImage(.failure):
                state.imageData = Data()
                return .none
                
            }
        }
    }
}
