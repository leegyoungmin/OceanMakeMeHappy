//
//  PhotoListStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation
import SwiftUI

struct PhotoFolderStore: ReducerProtocol {
    struct State: Equatable {
        var folders: [Folder] = []
        var folderName: String = ""
        var isPresentAlert: Bool = false
        
        struct Folder: Identifiable, Equatable {
            let id: UUID
            let name: String
            let description: String?
        }
    }
    
    enum Action: Equatable {
        case onAppear
        case tapAddFolder
        case alertDismiss
        
        // Inner Action
        case _textChanged(String)
        case _setAlertState(Bool)
        case _createFolder
        case _fetchFolders
        case _fetchFolderResponse(TaskResult<[Folder]>)
    }
    
    @Dependency(\.coreDataClient) var coreDataClient
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .task {
                    ._fetchFolders
                }
                
            case .tapAddFolder:
                state.isPresentAlert = true
                return .none
                
            case .alertDismiss:
                return .concatenate(
                    .send(._setAlertState(false)),
                    .send(._createFolder)
                )
                
            case let ._textChanged(folderName):
                state.folderName = folderName
                return .none
                
            case let ._setAlertState(isPresent):
                state.isPresentAlert = isPresent
                return .none
                
            case ._createFolder:
//                let name = state.folderName
//                let folder = State.Folder(name: name)
//                state.folders.append(folder)
//                state.folderName = ""
                return .none
                
            case ._fetchFolders:
                return .task {
                    await ._fetchFolderResponse(
                        TaskResult {
                            try await coreDataClient.loadFolders()
                        }
                    )
                }
                
            case let ._fetchFolderResponse(.success(folders)):
                state.folders = folders.map {
                    return State.Folder(id: $0.id ?? UUID(), name: $0.title ?? "", description: $0.body ?? "")
                }
                
                return .none
                
            case ._fetchFolderResponse(.failure):
                return .none
            }
        }
    }
}
