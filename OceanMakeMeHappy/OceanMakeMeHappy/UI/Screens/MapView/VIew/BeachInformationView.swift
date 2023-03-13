//
//  BeachInformationView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI

struct BeachInformationView: View {
    @StateObject var viewModel: BeachInformationViewModel
    var body: some View {
        ScrollView {
            StickyHeader {
                ZStack {
                    Color.red
                }
            }
            
            Text(viewModel.beach.name)
            
            ForEach($viewModel.information.alltag, id: \.self) {
                Text($0.wrappedValue)
            }
            
            
        }
    }
}




struct StickyHeader<Content: View>: View {
    var minHeight: CGFloat
    var content: Content
    
    init(minHeight: CGFloat = 200, @ViewBuilder content: () -> Content) {
        self.minHeight = minHeight
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            if geometry.frame(in: .global).minY <= .zero {
                content
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .center
                    )
            } else {
                content
                    .offset(y: -geometry.frame(in: .global).minY)
                    .frame(width: geometry.size.width, height: geometry.frame(in: .global).minY + geometry.size.height)
            }
        }
        .frame(minHeight: minHeight)
    }
}

//struct BeachInformationView_Previews: PreviewProvider {
//    static let viewModel = BeachInformationViewModel(
//        beach: Beach.mockBeach,
//        information: BeachInformation.mockBeachInformation
//    )
//    static var previews: some View {
//        BeachInformationView(viewModel: viewModel)
//    }
//}


