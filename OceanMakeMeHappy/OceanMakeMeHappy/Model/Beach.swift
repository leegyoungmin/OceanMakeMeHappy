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
    let address: String
    let contentId: String?
    let description: String?
    
    enum CodingKeys: CodingKey {
        case num
        case name
        case address
        case longitude
        case latitude
        case contentId
        case description
    }
    
    init(num: Int, name: String, address: String, longitude: Double, latitude: Double, contentId: String? = nil, description: String? = nil) {
        self.num = num
        self.name = name
        self.address = address
        self.location = NMGLatLng(lat: latitude, lng: longitude)
        self.contentId = contentId
        self.description = description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.num = try container.decode(Int.self, forKey: .num)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.contentId = try? container.decode(String.self, forKey: .contentId)
        self.description = try? container.decode(String.self, forKey: .description)
        
        let longitude = try container.decode(Double.self, forKey: .longitude)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        
        self.location = NMGLatLng(lat: latitude, lng: longitude)
    }
}

extension Beach {
    static var mockBeach: Self {
        return Beach(num: 1, name: "함덕해수욕장", address: "제주특별자치도 제주시 조천읍 함덕리", longitude: 126.66971744987154, latitude: 33.54311160440626)
    }
}
