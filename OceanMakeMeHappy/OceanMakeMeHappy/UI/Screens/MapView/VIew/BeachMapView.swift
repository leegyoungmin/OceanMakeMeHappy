//
//  BeachMapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BeachMapView: View {
    @StateObject var mapViewModel: MapViewModel
    
    init() {
        _mapViewModel = StateObject(wrappedValue: MapViewModel())
    }
    
    var body: some View {
        ZStack {
            NaverMapView(viewModel: mapViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                ZStack {
                    ForEach(mapViewModel.beachList, id: \.num) { beach in
                        if mapViewModel.selectedIndex == beach.num {
                            BeachPreviewView(beach: beach)
                                .environmentObject(mapViewModel)
                                .shadow(
                                    color: Color.gray.opacity(0.3),
                                    radius: 10
                                )
                                .padding()
                                .transition(
                                    .asymmetric(
                                        insertion: .move(edge: .trailing), removal: .move(edge: .leading)
                                    )
                                )
                        }
                    }
                }
            }
        }
        
    }
}

struct BeachMapView_Previews: PreviewProvider {
    static var previews: some View {
        BeachMapView()
    }
}
