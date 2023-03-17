//
//  NaverMapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import NMapsMap
import SwiftUI

struct NaverMapView: UIViewRepresentable {
    let viewStore: ViewStoreOf<NaverMapStore>
    
    init(store: StoreOf<NaverMapStore>) {
        self.viewStore = ViewStore(store)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapController = configureNaverMap()
        
        configureMarker(with: viewStore.beachList, to: mapController)
        
        guard let firstLocation = viewStore.locations.first else { return mapController }
        
        let defaultPosition = NMFCameraPosition(firstLocation, zoom: 9)
        let cameraUpdate = NMFCameraUpdate(position: defaultPosition)
        mapController.mapView.moveCamera(cameraUpdate)
        
        return mapController
    }
     
    private func touchedMarker(marker overlay: NMFOverlay) -> Bool {
        guard let marker = overlay as? NMFMarker,
              let beachInfo = marker.userInfo["beachInfo"] as? Beach,
              let mapView = marker.mapView else {
            return false
        }
        
        viewStore.send(._resetRemainMaker(marker: marker, mapView: mapView))
        
        viewStore.send(.selectBeach(beachInfo.num))
        
        if marker.iconImage == NMF_MARKER_IMAGE_LIGHTBLUE { // UnSelected -> Selected
            withAnimation {
                marker.iconImage = NMF_MARKER_IMAGE_BLUE
                marker.width *= 2
                marker.height *= 2
                let cameraUpdate = NMFCameraUpdate(scrollTo: marker.position, zoomTo: 18)
                cameraUpdate.reason = Int32(NMFMapChangedByControl)
                cameraUpdate.animation = .fly
                cameraUpdate.animationDuration = 1
                marker.mapView?.moveCamera(cameraUpdate)
            }
            return true
        }
        
        return false
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) { }
}

// MARK: Configure Naver Map
extension NaverMapView {
    private func configureNaverMap() -> NMFNaverMapView {
        let view = NMFNaverMapView()
        
        view.showZoomControls = false
        view.showCompass = false
        view.showScaleBar = false
        view.showLocationButton = false
        
        view.mapView.locale = "ko-KR"
        view.mapView.positionMode = .normal
        view.mapView.isNightModeEnabled = true
        view.mapView.zoomLevel = 9
        view.mapView.maxZoomLevel = 18
        view.mapView.allowsRotating = false
        view.mapView.logoInteractionEnabled = false
        
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_BUILDING, isEnabled: false)
        view.mapView.setLayerGroup(NMF_LAYER_GROUP_MOUNTAIN, isEnabled: true)
        view.mapView.symbolScale = 1
        
        view.mapView.extent = NMGLatLngBounds(latLngs: viewStore.locations)
        
        return view
    }
    
    private func configureMarker(with beaches: [Beach], to mapController: NMFNaverMapView) {
        viewStore.beachList.forEach {
            let location = $0.location
            let marker = NMFMarker(position: location)
            marker.width = 16
            marker.height = 21
            marker.captionText = $0.name
            marker.mapView = mapController.mapView
            marker.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
            marker.userInfo = ["beachInfo": $0]
            marker.isHideCollidedCaptions = true
            marker.isHideCollidedSymbols = true
            marker.touchHandler = touchedMarker(marker:)
            
            if $0.num == 1 {
                marker.height *= 2
                marker.width *= 2
                marker.iconImage = NMF_MARKER_IMAGE_BLUE
            }
        }
    }
}

