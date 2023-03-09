//
//  MapViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import NMapsMap

final class MapViewModel: ObservableObject {
    @Published var beachList = [Beach]()
    @Published var selectedIndex: Int = 1
    var locations: [NMGLatLng] = []
    
    init() {
        if let beachList: Beaches = JSONDecoder().decodeLocalFile(with: "BeachList") {
            self.beachList = beachList.items
            self.locations = beachList.items.map { $0.location }
        }
        
        for beach in beachList {
            let urlString = "https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=\(beach.location.lng.description),\(beach.location.lat.description)&output=json"
            guard let url = URL(string: urlString) else {
                return
            }
            
            var request = URLRequest(url: url)
            request.setValue("m7udxzf586", forHTTPHeaderField: "X-NCP-APIGW-API-KEY-ID")
            request.setValue("V7CJ3BGHPbWa7KUS8VopuFABFnRMrMw53ucSIC3a", forHTTPHeaderField: "X-NCP-APIGW-API-KEY")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let response = response as? HTTPURLResponse else { return }
                guard let data = data else { return }
                print(String(data: data, encoding: .utf8))
            }
            .resume()
        }
    }
}

extension MapViewModel {
    
}
