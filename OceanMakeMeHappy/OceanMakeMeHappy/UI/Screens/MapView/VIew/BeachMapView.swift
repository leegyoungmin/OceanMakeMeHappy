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
                
                HStack {
                    Spacer()
                    
                    TabView(selection: $mapViewModel.selectedIndex) {
                        ForEach(mapViewModel.beachList, id: \.num) { beach in
                            ZStack {
                                Color.accentColor
                                
                                Text(beach.name)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            .tag(beach.num)
                        }
                        .padding(10)
                    }
                    .frame(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * 0.2
                    )
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
                    Spacer()
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
