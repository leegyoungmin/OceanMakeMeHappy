//
//  CoreDataClient.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct CoreDataClient {
    var loadFolders: @Sendable () async throws -> [Folder]
    var addFolder: @Sendable (PhotoFolderStore.State.Folder) async throws -> [Folder]
}

extension DependencyValues {
    var coreDataClient: CoreDataClient {
        get { self[CoreDataClient.self] }
        set { self[CoreDataClient.self] = newValue }
    }
}

extension CoreDataClient: DependencyKey {
    static let liveValue = CoreDataClient(
        loadFolders: {
            return CoreData.shared.fetchFolders()
        },
        addFolder: { folder in
            CoreData.shared.addFolder(folder: folder)
            return CoreData.shared.fetchFolders()
        }
    )
}
