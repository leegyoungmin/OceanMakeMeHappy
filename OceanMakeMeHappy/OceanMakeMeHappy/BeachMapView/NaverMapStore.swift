//
//  NaverMapStore.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import NMapsMap

struct NaverMapStore: ReducerProtocol {
    struct State: Equatable {
        let beachList: [Beach]
        let locations: [NMGLatLng]
        
        init(beachList: [Beach]) {
            self.beachList = beachList
            self.locations = beachList.map(\.location)
        }
    }
    
    enum Action: Equatable {
        case selectBeach(Int)
        
        // Inner Action
        case _resetRemainMaker(marker: NMFMarker, mapView: NMFMapView)
    }
    
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .selectBeach:
                return .none
                
            case let ._resetRemainMaker(marker, mapView):
                state.locations.filter { $0 != marker.position }
                    .forEach {
                        let point = mapView.projection.point(from: $0)
                        guard let markers = mapView.pickAll(point, withTolerance: 2) as? [NMFMarker] else { return }
                        
                        for mark in markers {
                            mark.iconImage = NMF_MARKER_IMAGE_LIGHTBLUE
                            mark.width = 16
                            mark.height = 21
                        }
                    }
                
                return .none
            }
        }
    }
}
