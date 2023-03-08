//
//  NaverMapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    private var subscribers = Set<AnyCancellable>()
    @StateObject var mapViewModel: MapViewModel
    
    init(viewModel: MapViewModel) {
        _mapViewModel = StateObject(wrappedValue: viewModel)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapController = configureNaverMap()
        
        configureMarker(with: mapViewModel.beachList, to: mapController)
        
        mapController.mapView.touchDelegate = context.coordinator
        mapController.mapView.addCameraDelegate(delegate: context.coordinator)
        mapController.mapView.addOptionDelegate(delegate: context.coordinator)
        
        return mapController
    }
    
     
    private func touchedMarker(marker overlay: NMFOverlay) -> Bool {
        guard let marker = overlay as? NMFMarker else { return false }
        
        if marker.iconImage == NMF_MARKER_IMAGE_LIGHTBLUE { // UnSelected -> Selected
            withAnimation {
                marker.iconImage = NMF_MARKER_IMAGE_BLUE
                marker.width *= 2
                marker.height *= 2
            }
            return true
        }
        
        if marker.iconImage == NMF_MARKER_IMAGE_BLUE { // Selected -> UnSelected
            withAnimation {
                marker.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
                marker.width /= 2
                marker.height /= 2
            }
            return true
        }
        
        return true
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) { }
    
    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
            print(symbol)
            return true
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
}

// MARK: Configure Naver Map
extension NaverMapView {
    private func configureNaverMap() -> NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.showCompass = false
        view.showScaleBar = false
        view.showLocationButton = false
        
        
        view.mapView.positionMode = .normal
        view.mapView.isNightModeEnabled = true
        view.mapView.allowsZooming = false
        view.mapView.symbolScale = .zero
        view.mapView.zoomLevel = 9
        view.mapView.allowsRotating = false
        view.mapView.logoInteractionEnabled = false
        
        view.mapView.extent = NMGLatLngBounds(latLngs: mapViewModel.beachList.map { $0.location })
        
        return view
    }
    
    private func configureMarker(with beaches: [Beach], to mapController: NMFNaverMapView) {
        mapViewModel.beachList.forEach {
            let location = $0.location
            let marker = NMFMarker(position: location)
            marker.width = 16
            marker.height = 21
            marker.mapView = mapController.mapView
            marker.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
            marker.userInfo = ["name": $0.name]
            marker.touchHandler = touchedMarker(marker:)
        }
    }
}

