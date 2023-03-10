//
//  BeachInformation.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

// MARK: - BeachInformation
struct BeachInformationResponse: Codable {
    let items: [BeachInformation]
    
    var beachInformation: BeachInformation? {
        guard let information = items.first else { return nil }
        return information
    }
}

// MARK: - Item
struct BeachInformation: Codable {
    let alltag: [String]
    let contentsid, address, roadaddress: String
    let introduction: String
    let photoInformation: PhotoInformation
    
    enum CodingKeys: String, CodingKey {
        case alltag
        case contentsid
        case address
        case roadaddress
        case introduction
        case photoInformation = "repPhoto"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let tag = try container.decode(String.self, forKey: .alltag)
        self.alltag = tag.components(separatedBy: ",")
        self.contentsid = try container.decode(String.self, forKey: .contentsid)
        self.address = try container.decode(String.self, forKey: .address)
        self.roadaddress = try container.decode(String.self, forKey: .roadaddress)
        self.introduction = try container.decode(String.self, forKey: .introduction)
        self.photoInformation = try container.decode(PhotoInformation.self, forKey: .photoInformation)
    }
}

// MARK: - RepPhoto
struct PhotoInformation: Codable {
    let description: String
    let photoPaths: PhotoPaths
    
    enum CodingKeys: String, CodingKey {
        case description = "descseo"
        case photoPaths = "photoid"
    }
}

// MARK: - Photoid
struct PhotoPaths: Codable {
    let id: Int
    let imagePath, thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {
        case id = "photoid"
        case imagePath = "imgpath"
        case thumbnailPath = "thumbnailpath"
    }
}
