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
            let id = UUID()
            let name: String
            let description: String?
            
            init(name: String, description: String? = nil) {
                self.name = name
                self.description = description
            }
        }
    }
    
    enum Action: Equatable {
        case tapAddFolder
        case alertDismiss
        
        // Inner Action
        case _textChanged(String)
        case _setAlertState(Bool)
        case _createFolder
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
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
                let name = state.folderName
                let folder = State.Folder(name: name)
                state.folders.append(folder)
                state.folderName = ""
                return .none
            }
        }
    }
}
