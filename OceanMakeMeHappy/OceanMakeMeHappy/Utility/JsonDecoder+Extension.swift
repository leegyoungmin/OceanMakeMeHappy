//
//  Bundle+Extension.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Foundation

extension JSONDecoder {
    func decodeLocalFile<Model: Decodable>(with fileName: String) -> Model? {
        guard let fileLocation = Bundle.main.url(
            forResource: fileName,
            withExtension: "json"
        ) else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: fileLocation) else { return nil }
        
        guard let decodeData = try? self.decode(Model.self, from: data) else { return nil }
        
        return decodeData
    }
}
