//
//  OceanMakeMeHappyApp.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        

import SwiftUI
import NMapsMap

@main
struct OceanMakeMeHappyApp: App {
    
    init() {
        if let apiKey = Bundle.main.object(forInfoDictionaryKey: "NMFClientId") as? String {
            NMFAuthManager.shared().clientId = apiKey
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
