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
            WithViewStore(store) { viewStore in
                ScrollViewHeaderImage(Image(uiImage: UIImage(data: viewStore.imageData) ?? UIImage()))
                    .opacity(visibleRatio)
            }
            
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
                        .fontWeight(.heavy)
                    
                    Text(viewStore.beach.address)
                }
            }
            
            Spacer()
        }
    }
    
    var tagScrollView: some View {
        WithViewStore(store) { viewStore in
            if let tags = viewStore.information?.alltag {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack {
                        ForEach(tags, id: \.self) { value in
                            Text("# " + value)
                                .font(.headline)
                                .fontWeight(.thin)
                        }
                    }
                    .padding(10)
                    .cornerRadius(6)
                }
                .background(Material.thin)
                .frame(maxHeight: 44)
                .cornerRadius(6)
                .onAppear {
                    print(tags)
                }
            }
            
        }
    }
    
    var headLineTextView: some View {
        WithViewStore(store) { viewStore in
            if let introduction = viewStore.information?.introduction {
                Text(introduction)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.9)
                    .truncationMode(.middle)
                    .font(.title3.bold())
                    .padding()
            }
        }
    }
    
    var descriptionTextView: some View {
        WithViewStore(store.scope(state: \.beach)) { beach in
            if let description = beach.description {
                Text(description)
                    .padding(.horizontal)
            }
        }
    }
    
    @ViewBuilder
    func LinkView(title: String, subTitle: String, with linkPath: URL) -> some View {
        GroupBox {
            HStack {
                Image(systemName: "globe")
                Text(title)
                
                Spacer()
                
                Group {
                    Image(systemName: "arrow.up.right.square")
                    
                    Link(subTitle, destination: linkPath)
                }
            }
        }
        .padding([.top,.horizontal])
    }
    
    var body: some View {
        ScrollViewWithStickyHeader(
            header: header,
            headerHeight: 250,
            onScroll: handleOffset
        ) {
            VStack(spacing: 0) {
                VStack(alignment: .leading) {
                    headerTitle
                        .foregroundColor(.black)
                    
                    tagScrollView
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                
                headLineTextView
                
                descriptionTextView
                
                WithViewStore(store.scope(state: \.beach)) { beach in
                    if let url = URL.generateNaverMapSearch(with: beach.name) {
                        LinkView(title: "네이버 지도로 보기", subTitle: beach.name, with: url)
                    }
                }
                
                WithViewStore(store) { viewStore in
                    if let contentId = viewStore.beach.contentId,
                       let url = URL.generateJejuSearch(with: contentId) {
                        
                        LinkView(title: "자료 출처", subTitle: "VISIT JEJU", with: url)
                    }
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
        .onAppear {
            ViewStore(store).send(.onAppear)
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


