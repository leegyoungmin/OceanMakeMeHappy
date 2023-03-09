//
//  Beach.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation
import NMapsMap

import Foundation

// MARK: - Beach
struct Beaches: Decodable {
    let items: [Beach]
}


// MARK: - Item
struct Beach: Decodable, Hashable {
    let num: Int
    let name: String
    let location: NMGLatLng
    
    enum CodingKeys: CodingKey {
        case num
        case name
        case longitude
        case latitude
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.num = try container.decode(Int.self, forKey: .num)
        self.name = try container.decode(String.self, forKey: .name)
        
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        
        self.location = NMGLatLng(lat: latitude, lng: longitude)
    }
}
