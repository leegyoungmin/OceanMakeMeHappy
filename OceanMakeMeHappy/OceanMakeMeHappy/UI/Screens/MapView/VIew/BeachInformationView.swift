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
                
                if let description = viewModel.beach.description {
                    Text(description)
                }
                
                if let url = URL(string: "nmap://search?query=\(viewModel.beach.name.encodeURL() ?? "")&appname=com.minii.OceanMakeMeHappy") {
                    GroupBox {
                        Link(destination: url) {
                            Text("네이버지도로 검색하기")
                        }
                    } label: {
                        Image(systemName: "network")
                    }
                }
            }
            .padding(10)
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


