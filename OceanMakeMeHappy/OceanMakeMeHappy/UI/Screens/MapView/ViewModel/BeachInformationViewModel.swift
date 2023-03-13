//
//  BeachInformationViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import SwiftUI

final class BeachInformationViewModel: ObservableObject {
    private let imageService: ImageService
    private var subscribers = Set<AnyCancellable>()
    
    @Published var beach: Beach
    @Published var information: BeachInformation
    @Published var mainImage: Image = Image("IconImage")
    
    init(beach: Beach, information: BeachInformation? = nil, imageService: ImageService = RealImageService()) {
        self.beach = beach
        
        if let information = information {
            self.information = information
        } else {
            self.information = .init(
                alltag: [],
                contentsid: beach.contentId ?? "",
                address: beach.address,
                roadaddress: beach.address,
                introduction: ""
            )
        }
        
        self.imageService = imageService
        
        guard let url = information?.imagePath else { return }
        
        imageService.load(url: url)
            .replaceError(with: Image("IconImage"))
            .sink { self.mainImage = $0 }
            .store(in: &subscribers)
    }
}
