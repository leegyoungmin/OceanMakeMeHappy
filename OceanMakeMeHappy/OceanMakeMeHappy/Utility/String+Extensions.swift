//
//  String+Extensions.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

extension String {
    func encodeURL() -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    func decodeURL() -> String {
        return self.removingPercentEncoding ?? ""
    }
}
