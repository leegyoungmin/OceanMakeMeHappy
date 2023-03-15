//
//  BeachInformation.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

// MARK: - BeachInformation
struct BeachInformationResponse: Codable {
    let items: [BeachInformation]
    
    var beachInformation: BeachInformation? {
        guard let information = items.first else { return nil }
        return information
    }
}

// MARK: - Item
struct BeachInformation: Codable, Hashable {
    var alltag: [String]
    let contentsid, address, roadaddress: String
    let introduction: String
    var photoInformation: PhotoInformation? = nil
    var thumbnailPath: URL? {
        guard let path = photoInformation?.photoPaths.thumbnailPath else {
            return nil
        }
        return URL(string: path)
    }
    
    var imagePath: URL? {
        guard let path = photoInformation?.photoPaths.imagePath else {
            return nil
        }
        return URL(string: path)
    }
    
    enum CodingKeys: String, CodingKey {
        case alltag
        case contentsid
        case address
        case roadaddress
        case introduction
        case photoInformation = "repPhoto"
    }
    
    init(alltag: [String], contentsid: String, address: String, roadaddress: String, introduction: String, photoInformation: PhotoInformation? = nil) {
        self.alltag = alltag
        self.contentsid = contentsid
        self.address = address
        self.roadaddress = roadaddress
        self.introduction = introduction
        self.photoInformation = photoInformation
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
struct PhotoInformation: Codable, Hashable {
    let description: String
    let photoPaths: PhotoPaths
    
    enum CodingKeys: String, CodingKey {
        case description = "descseo"
        case photoPaths = "photoid"
    }
}

// MARK: - Photoid
struct PhotoPaths: Codable, Hashable {
    let id: Int
    let imagePath, thumbnailPath: String
    
    enum CodingKeys: String, CodingKey {
        case id = "photoid"
        case imagePath = "imgpath"
        case thumbnailPath = "thumbnailpath"
    }
}

extension BeachInformation {
    static var mockBeachInformation: Self {
        return .init(
            alltag: [
                "해수욕장", "액티비티", "아이", "맑음", "여름", "자연경관", "체험", "레저/체험", "해변", "물놀이", "어린이", "수상레저", "반려동물", "반려동물동반입장", "혼저옵서개", "반려동물동반해변", "공용주차장", "화장실", "편의점", "음료대", "유도 및 안내시설", "경보 및 피난시설", "단차없음", "장애인 화장실", "장애인 전용 주차장", "어려움", "실외", "1~2시간"
            ],
            contentsid: "CONT_000000000500693",
            address: "제주특별자치도 제주시 조천읍 함덕리 1008-1",
            roadaddress: "제주특별자치도 제주시 조천읍 조함해안로 519-10",
            introduction: "에매랄드처럼 빛나는 \'한국의 몰디브\'",
            photoInformation: PhotoInformation(
                description: "함덕해수욕장",
                photoPaths: PhotoPaths(
                    id: 2019022561221,
                    imagePath: "https://api.cdn.visitjeju.net/photomng/imgpath/201908/29/6fa8ac92-91b1-4314-a05e-0c962f9ab2f8.jpg",
                    thumbnailPath: "https://api.cdn.visitjeju.net/photomng/thumbnailpath/201908/29/eebc954b-bfb0-4dda-a593-45427c1e6711.jpg"
                )
            )
        )
    }
}
