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
        NMFAuthManager.shared().clientId = "m7udxzf586"
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
