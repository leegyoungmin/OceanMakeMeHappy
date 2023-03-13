//
//  BeachInformationViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine

final class BeachInformationViewModel: ObservableObject {
    @Published var beach: Beach
    @Published var information: BeachInformation
    
    init(beach: Beach, information: BeachInformation) {
        self.beach = beach
        self.information = information
    }
}
