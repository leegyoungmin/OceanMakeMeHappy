//
//  ThumbnailModifier.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct ThumbnailImageModifier: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height, alignment: .center)
            .cornerRadius(6)
    }
}

extension View {
    func thumbnailStyle(size: CGSize = CGSize(width: 100, height: 100)) -> some View {
        modifier(ThumbnailImageModifier(width: size.width, height: size.height))
    }
}
