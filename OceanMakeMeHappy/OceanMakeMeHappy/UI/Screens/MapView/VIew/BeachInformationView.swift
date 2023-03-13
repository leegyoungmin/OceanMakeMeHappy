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
        }
    }
    
    var headerTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.beach.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                Text(viewModel.beach.address)
            }
            
            Spacer()
        }
        .opacity(visibleRatio)
    }
    
    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: 250,
            onScroll: handleOffset
        ) {
            
            VStack(alignment: .leading) {
                headerTitle
                    .foregroundColor(.black)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach($viewModel.information.alltag, id: \.self) {
                            Text("# " + $0.wrappedValue)
                                .font(.headline)
                                .fontWeight(.thin)
                        }
                    }
                    .padding(10)
                }
                .background(Material.thin)
                .cornerRadius(6)
                .frame(maxHeight: 44)
                
                Text(viewModel.information.introduction)
                    .font(.headline)
                    .padding(.vertical)
            }
            .padding(10)
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


