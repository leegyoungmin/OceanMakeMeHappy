//
//  ThumbnailModifier.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct ThumbnailImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(6)
    }
}

extension View {
    func thumbnailStyle() -> some View {
        modifier(ThumbnailImageModifier())
    }
}
