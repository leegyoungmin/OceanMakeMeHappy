//
//  MapPreviewViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class MapPreviewViewModel: ObservableObject {
    private let service: BeachInformationService
    private var cancellables = Set<AnyCancellable>()
    
    @Published var information: BeachInformation?

    init(contentId: String, service: BeachInformationService) {
        self.service = service
        
        service.loadBeachInformation(contentId: contentId)
            .sink(receiveCompletion: handleError) {
                self.information = $0
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
