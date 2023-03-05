//
//  ContentView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import MapKit
import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    private var navigationTitle: String {
        return "Navigation Title (\(selectedIndex))"
    }
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                MapView()
                    .tabItem {
                        Label("지도로 보기", image: "")
                    }
                    .tag(0)
                
                Text("Example")
                    .tabItem {
                        Label("설정", image: "")
                    }
                    .tag(1)
            }
            .navigationTitle(navigationTitle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
