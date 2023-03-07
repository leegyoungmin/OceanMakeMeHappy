//
//  NaverMapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    @StateObject var mapViewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        _mapViewModel = StateObject(wrappedValue: viewModel)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        
        view.mapView.positionMode = .normal
        view.mapView.isNightModeEnabled = true
        view.mapView.allowsZooming = false
        view.mapView.zoomLevel = 8
        
        view.mapView.touchDelegate = context.coordinator
        view.mapView.addCameraDelegate(delegate: context.coordinator)
        view.mapView.addOptionDelegate(delegate: context.coordinator)
        
        view.mapView.extent = NMGLatLngBounds(latLngs: mapViewModel.locations)
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) { }
    
    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {

            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
}
