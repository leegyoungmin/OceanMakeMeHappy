//
//  ImageClient.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct ImageClient {
    var loadImageData: @Sendable (URL?) async throws -> Data
}

extension DependencyValues {
    var imageClient: ImageClient {
        get { self[ImageClient.self] }
        set { self[ImageClient.self] = newValue}
    }
}

extension ImageClient: DependencyKey {
    static var liveValue = ImageClient(
        loadImageData: { imagePath in
            guard let url = imagePath else {
                throw ImageLoadError.invalidURL
            }
            let (data, _) = try await URLSession.shared.data(from: url)
            
            return data
        }
    )
}

extension ImageClient {
    enum ImageLoadError: Error {
        case invalidURL
    }
}
