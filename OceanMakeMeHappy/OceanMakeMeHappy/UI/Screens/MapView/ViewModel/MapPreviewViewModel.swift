//
//  MapPreviewViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import SwiftUI

final class MapPreviewViewModel: ObservableObject {
    private let service: BeachInformationService
    private let imageService: ImageService
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var beachImage: Image = Image("IconImage")
    @Published var information: BeachInformation?

    init(contentId: String, service: BeachInformationService, imageService: ImageService) {
        self.service = service
        self.imageService = imageService
        
        service.loadBeachInformation(contentId: contentId)
            .compactMap {
                self.information = $0
                return $0?.thumbnailPath
            }
            .flatMap {
                imageService.load(url: $0)
            }
            .sink(receiveCompletion: handleError) {
                self.beachImage = $0
            }
            .store(in: &cancellables)
    }
    
    private func handleError(with error: Subscribers.Completion<Error>) {
        switch error {
        case .failure(let error):
            debugPrint(error)
        default:
            return
        }
    }
}
