//
//  BeachInformationView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import SwiftUI
import DSScrollKit

struct BeachInformationView: View {
    @StateObject var viewModel: BeachInformationViewModel
    @State var offset: CGPoint = .zero
    @State var visibleRatio: CGFloat = .zero
    
    func handleOffset(_ scrollOffset: CGPoint, visibleRatio: CGFloat) {
        self.offset = scrollOffset
        self.visibleRatio = visibleRatio
    }
    
    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            ScrollViewHeaderImage(viewModel.mainImage)
                .opacity(visibleRatio)
            
            Color.white
                .opacity(1 - visibleRatio)
            
            headerTitle
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.4), radius: 1, x: 1, y: 1)
        }
    }
    
    var headerTitle: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.beach.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            Text(viewModel.beach.address)
        }
        .padding(20)
        .opacity(visibleRatio)
    }
    
    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: 250,
            onScroll: handleOffset
        ) {
            ForEach($viewModel.information.alltag, id: \.self) {
                Text($0.wrappedValue)
                Text($0.wrappedValue)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(viewModel.beach.name)
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .shadow(color: .white.opacity(0.4), radius: 1, x: 1, y: 1)
                    .opacity(1 - visibleRatio)
            }
        }
    }
}

struct BeachInformationView_Previews: PreviewProvider {
    static let viewModel = BeachInformationViewModel(
        beach: Beach.mockBeach,
        information: BeachInformation.mockBeachInformation
    )
    static var previews: some View {
        BeachInformationView(viewModel: viewModel)
    }
}


