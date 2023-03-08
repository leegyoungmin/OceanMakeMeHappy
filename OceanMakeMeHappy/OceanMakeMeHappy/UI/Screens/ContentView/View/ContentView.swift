//
//  ContentView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import MapKit
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    
    init() {
        _viewModel = StateObject(wrappedValue: ContentViewModel())
    }

    var body: some View {
        NavigationView {
            ZStack {
                NaverMapView(viewModel: MapViewModel())
                    .edgesIgnoringSafeArea(.all)
                
                roundedTabBar()
            }
            .customNavigationBar(centerView: {
                Image("IconImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            })
        }
    }
}

extension ContentView {
    @ViewBuilder
    private func roundedTabBar() -> some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                ForEach(viewModel.tabBarItems.indices, id: \.self) { index in
                    let item = viewModel.tabBarItems[index]
                    
                    Button {
                        viewModel.selectedIndex = index
                    } label: {
                        Image(systemName: item.imageName)
                    }
                    .foregroundColor(viewModel.isSelectedIndex(with: index) ? .accentColor : .black)
                }
                
                Spacer()
            }
            .frame(maxWidth: 200, minHeight: 50)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(radius: 5)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
