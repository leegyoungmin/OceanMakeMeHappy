//
//  CoreDataClient.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture

struct CoreDataClient {
    var loadFolders: @Sendable () async throws -> [Folder]
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
            let folders = CoreData.shared.fetchFolders()
            return folders
        }
    )
}
