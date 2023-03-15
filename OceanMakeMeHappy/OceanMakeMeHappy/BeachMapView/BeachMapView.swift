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
            ZStack {
                NavigationLink(isActive: $mapViewModel.isPresentDetail) {
                    if let detailBeach = mapViewModel.detailBeach {
                        let viewModel = BeachInformationViewModel(beach: detailBeach, information: mapViewModel.detailInformation)
                        
                        BeachInformationView(viewModel: viewModel)
                    }
                } label: {
                    EmptyView()
                }
            }
            
            NaverMapView(beachList: mapViewModel.beachList)
                .environmentObject(mapViewModel)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                
                ZStack {
                    ForEach(mapViewModel.beachList, id: \.num) { beach in
                        if mapViewModel.selectedIndex == beach.num {
                            BeachPreviewCardView(beach: beach)
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
