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
    
    private func resetRemainMarker(marker: NMFMarker) {
        let mapView = marker.mapView
        
        mapViewModel.locations.filter { $0 != marker.position }.forEach {
            guard let point = mapView?.projection.point(from: $0) else { return }
            guard let markers = mapView?.pickAll(point, withTolerance: 2) as? [NMFMarker] else { return }
            
            for mark in markers {
                mark.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
                mark.width = 16
                mark.height = 21
            }
        }
    }
     
    private func touchedMarker(marker overlay: NMFOverlay) -> Bool {
        guard let marker = overlay as? NMFMarker else { return false }
        
        resetRemainMarker(marker: marker)
        
        if marker.iconImage == NMF_MARKER_IMAGE_LIGHTBLUE { // UnSelected -> Selected
            withAnimation {
                marker.iconImage = NMF_MARKER_IMAGE_BLUE
                marker.width *= 2
                marker.height *= 2
                let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position, zoomTo: 15)
                cameraUpdate.reason = Int32(NMFMapChangedByControl)
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1
                marker.mapView?.moveCamera(cameraUpdate)
            }
            return true
        }
        
        return true
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) { }
    
    class Coordinator: NSObject, NMFMapViewTouchDelegate, NMFMapViewCameraDelegate, NMFMapViewOptionDelegate {
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            let cameraUpdate = NMFCameraUpdate(scrollTo: latlng, zoomTo: 15)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            mapView.moveCamera(cameraUpdate)
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
        view.mapView.locale = "ko_KR"
        
        view.mapView.positionMode = .normal
        view.mapView.isNightModeEnabled = true
        view.mapView.zoomLevel = 9
        view.mapView.maxZoomLevel = 15
        view.mapView.allowsRotating = false
        view.mapView.logoInteractionEnabled = false
        
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: false)
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_MOUNTAIN, isEnabled: true)
        view.mapView.symbolScale = 1
        
        view.mapView.extent = NMGLatLngBounds(latLngs: mapViewModel.beachList.map { $0.location })
        
        return view
    }
    
    private func configureMarker(with beaches: [Beach], to mapController: NMFNaverMapView) {
        mapViewModel.beachList.forEach {
            let location = $0.location
            let marker = NMFMarker(position: location)
            marker.width = 16
            marker.height = 21
            marker.captionText = $0.name
            marker.mapView = mapController.mapView
            marker.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
            marker.userInfo = ["name": $0.name]
            marker.isHideCollidedCaptions = true
            marker.isHideCollidedMarkers = true
            marker.isHideCollidedSymbols = true
            marker.touchHandler = touchedMarker(marker:)
        }
    }
}

