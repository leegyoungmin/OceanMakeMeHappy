//
//  MapViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import MapKit

final class MapViewModel: ObservableObject {
    private let webService: BeachService
    
    private var subscribers = Set<AnyCancellable>()
    @Published var region = Constant.defaultRegion
    @Published var beachList = [Beach]()
    
    init(webService: BeachService = BeachListService(webRepository: BeachListWebRepository())) {
        self.webService = webService
        
        webService.load()
            .replaceError(with: [])
            .assign(to: \.beachList, on: self)
            .store(in: &subscribers)

    }
}

extension MapViewModel {
    enum Constant {
        static var defaultRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 33.3642,
                longitude: 126.5313
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.7, longitudeDelta: 0.7
            )
        )
    }
}
