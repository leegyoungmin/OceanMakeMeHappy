//
//  BeachInformationView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI
import DSScrollKit

struct BeachInformationView: View {
    let store: StoreOf<BeachInformationStore>
    @State var offset: CGPoint = .zero
    @State var visibleRatio: CGFloat = .zero
    
    func handleOffset(_ scrollOffset: CGPoint, visibleRatio: CGFloat) {
        self.offset = scrollOffset
        self.visibleRatio = visibleRatio
    }
    
    func header() -> some View {
        ZStack(alignment: .bottomLeading) {
            //            ScrollViewHeaderImage(store.mainImage)
            //                .opacity(visibleRatio)
            
            Color.white
                .opacity(1 - visibleRatio)
        }
    }
    
    var headerTitle: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                WithViewStore(store) { viewStore in
                    Text(viewStore.beach.name)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    
                    Text(viewStore.beach.address)
                }
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
//                        WithViewStore(store.scope(state: \.information)) { information in
//                            ForEach(information.alltag) {
//                                Text("# " + $0.wrappedValue)
//                                    .font(.headline)
//                                    .fontWeight(.thin)
//                            }
//                        }
                    }
                    .padding(10)
                }
                .background(Material.thin)
                .cornerRadius(6)
                .frame(maxHeight: 44)
            }
            .padding()
            
            WithViewStore(store) { viewStore in
                Text(viewStore.information.introduction)
                    .font(.headline)
                    .padding()
            }
            
            
            WithViewStore(store.scope(state: \.beach)) { beach in
                if let description = beach.description {
                    Text(description)
                        .padding()
                }
            }
            
            WithViewStore(store.scope(state: \.beach)) { beach in
                if let url = URL.generateNaverMapSearch(with: beach.name) {
                    GroupBox {
                        HStack {
                            Image(systemName: "globe")
                            Text("네이버 지도에서 보기")
                            
                            Spacer()
                            
                            Group {
                                Image(systemName: "arrow.up.right.square")
                                
                                Link(beach.name, destination: url)
                            }
                        }
                    }
                    .padding([.top,.horizontal])
                }
            }
            
            WithViewStore(store.scope(state: \.information)) { information in
                if let url = URL.generateJejuSearch(with: information.contentsid) {
                    GroupBox {
                        HStack {
                            Image(systemName: "globe")
                            Text("자료 출처")
                            
                            Spacer()
                            
                            Group {
                                Image(systemName: "arrow.up.right.square")
                                
                                Link("VISIT JEJU", destination: url)
                            }
                        }
                    }
                    .padding([.top,.horizontal])
                }
            }
        }.toolbar {
            ToolbarItem(placement: .principal) {
                WithViewStore(store) { viewStore in
                    Text(viewStore.beach.name)
                        .font(.headline)
                        .opacity(1 - visibleRatio)
                }
            }
        }
    }
}

struct BeachInformationView_Previews: PreviewProvider {
    static let store = Store(
        initialState: BeachInformationStore.State(
            beach: Beach.mockBeach,
            information: BeachInformation.mock
        ),
        reducer: BeachInformationStore()
    )
    static var previews: some View {
        BeachInformationView(store: store)
    }
}


