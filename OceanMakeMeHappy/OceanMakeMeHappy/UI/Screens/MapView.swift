//
//  MapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import MapKit
import SwiftUI

struct Beach: Identifiable {
    let id = UUID()
    let location: CLLocationCoordinate2D
}

struct MapView: View {
    enum Constant {
        static var basicRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 33.3642, longitude: 126.5313),
            span: MKCoordinateSpan(latitudeDelta: 0.9, longitudeDelta: 0.9)
        )
    }
    @State private var region = Constant.basicRegion
    let markers: [Beach] = [.init(location: .init(latitude: 33.4348090000, longitude: 126.9230210000))]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: markers) { marker in
            MapPin(coordinate: marker.location, tint: .blue)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
