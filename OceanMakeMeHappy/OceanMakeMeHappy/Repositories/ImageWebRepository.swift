//
//  ImageWebRepository.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import SwiftUI

protocol ImageWebRepository {
    func load(imageURL: URL) -> AnyPublisher<Image, Error>
}

struct RealImageWebRepository: ImageWebRepository {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func load(imageURL: URL) -> AnyPublisher<Image, Error> {
        return session.dataTaskPublisher(for: imageURL)
            .tryMap {
                guard let image = UIImage(data: $0.0) else {
                    throw APIError.imageDeserialization
                }
                
                return Image(uiImage: image)
            }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
