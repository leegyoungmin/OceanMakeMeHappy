//
//  BeachClient.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import ComposableArchitecture
import Foundation

struct BeachClient {
    var loadBeachList: @Sendable () async throws -> [Beach]
}

extension DependencyValues {
    var beachClient: BeachClient {
        get { self[BeachClient.self] }
        set { self[BeachClient.self] = newValue }
    }
}

extension BeachClient: DependencyKey {
    static let liveValue = BeachClient(
        loadBeachList: {
            guard let beaches: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") else {
                throw LocalFileError.loadFile
            }
            
            return beaches.items
        }
    )
}

extension BeachClient {
    enum LocalFileError: Error {
        case loadFile
    }
}
