//
//  MapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel: MapViewModel
    
    init(mapViewModel: MapViewModel) {
        _viewModel = StateObject(wrappedValue: mapViewModel)
    }
    
    var body: some View {
        Map(
            coordinateRegion: $viewModel.region,
            annotationItems: viewModel.beachList
        ) {
            MapPin(coordinate: $0.location)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(mapViewModel: MapViewModel())
    }
}
