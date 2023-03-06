//
//  Beach.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import MapKit

// MARK: - Item
struct Beach: Decodable, Identifiable {
    var id = UUID()
    
    let name: String
    let location: CLLocationCoordinate2D

    enum CodingKeys: String, CodingKey {
        case name = "sta_nm"
        case latitude = "lat"
        case longitude = "lon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        let lat = try container.decode(String.self, forKey: .latitude)
        let lon = try container.decode(String.self, forKey: .longitude)
        
        let latitude = Double(lat) ?? 0
        let longitude = Double(lon) ?? 0
        
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct Beaches: Decodable {
    let items: [Beach]
    
    enum CodingKeys: String, CodingKey {
        case getOceansBeachInfo
        case items = "item"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let infoContainer = try container.nestedContainer(
            keyedBy: CodingKeys.self,
            forKey: .getOceansBeachInfo
        )
        var itemsContainer = try infoContainer.nestedUnkeyedContainer(forKey: .items)
        
        var values = [Beach]()
        
        while itemsContainer.isAtEnd == false {
            let beach = try itemsContainer.decode(Beach.self)
            values.append(beach)
        }
        
        items = values
    }
}


