//
//  BeachInformationClient.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import Foundation

struct BeachInformationClient {
    var request: @Sendable (String?) async throws -> BeachInformation
}

extension BeachInformationClient: TestDependencyKey {
    static let previewValue = Self(
        request: { _ in BeachInformation.mock }
    )
    
    static let testValue = BeachInformationClient(
        request: unimplemented("\(Self.self).request")
    )
}

extension DependencyValues {
    var beachInformationClient: BeachInformationClient {
        get { self[BeachInformationClient.self] }
        set { self[BeachInformationClient.self] = newValue }
    }
}

extension BeachInformationClient: DependencyKey {
    static let liveValue = BeachInformationClient(
        request: { contentId in
            guard let contentId = contentId else {
                throw APIError.noneContentId
            }
            guard var components = URLComponents(string: "http://api.visitjeju.net") else {
                throw APIError.invalidURL
            }
            components.path = "/vsjApi/contents/searchList"
            components.queryItems = [
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "category", value: "c1"),
                URLQueryItem(name: "cid", value: contentId),
                URLQueryItem(name: "locale", value: "kr"),
                URLQueryItem(name: "apiKey", value: "4skn9eunxf928kqd")
            ]
            
            guard let url = components.url else {
                throw APIError.invalidURL
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(BeachInformationResponse.self, from: data)
            
            guard let beachInformation = response.beachInformation else {
                throw APIError.noResponse
            }
            return beachInformation
        }
    )
}


extension BeachInformationClient {
    enum APIError: Error {
        case noneContentId
        case invalidURL
        case noResponse
    }
}

extension BeachInformation {
    static let mock = Self.init(
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

