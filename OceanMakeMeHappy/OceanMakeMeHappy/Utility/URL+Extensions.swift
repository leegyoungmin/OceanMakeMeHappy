//
//  URL+Extensions.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

extension URL {
    static func generateNaverMapSearch(with queryPath: String) -> URL? {
        return URL(string: "nmap://search?query=\(queryPath.encodeURL())&appname=com.minii.OceanMakeMeHappy")
    }
    
    static func generateJejuSearch(with contentID: String) -> URL? {
        return URL(string: "https://m.visitjeju.net/kr/detail/view?contentsid=\(contentID)")
    }
}
