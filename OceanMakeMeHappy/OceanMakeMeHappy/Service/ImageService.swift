//
//  ImageService.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation
import SwiftUI

protocol ImageService {
    func load(url: URL) -> AnyPublisher<Image, Error>
}

struct RealImageService: ImageService {
    let webRepository: ImageWebRepository
    
    init(webRepository: ImageWebRepository = RealImageWebRepository()) {
        self.webRepository = webRepository
    }
    
    func load(url: URL) -> AnyPublisher<Image, Error> {
        return webRepository.load(imageURL: url)
    }
    
}
