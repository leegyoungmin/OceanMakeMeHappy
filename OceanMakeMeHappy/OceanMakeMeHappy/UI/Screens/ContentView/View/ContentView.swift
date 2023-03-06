//
//  ContentView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.
        
import MapKit
import SwiftUI

struct TabBarItem: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
}

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    let tabBarImages: [TabBarItem] = [
        TabBarItem(title: "", imageName: "map.fill"),
        TabBarItem(title: "설정", imageName: "person.circle.fill")
    ]
    private var navigationTitle: String {
        return tabBarImages[selectedIndex].title
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selectedIndex) {
                    MapView()
                        .tag(0)

                    Text("Example")
                        .tag(1)
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        ForEach(tabBarImages.indices, id: \.self) { index in
                            let item = tabBarImages[index]
                            
                            Button {
                                self.selectedIndex = index
                            } label: {
                                Image(systemName: item.imageName)
                            }
                            .foregroundColor(selectedIndex == index ? .blue : .black)
                        }
                        
                        Spacer()
                    }
                    .frame(maxWidth: 200)
                    .frame(minHeight: 50)
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                }
            }
            .customNavigationBar(leftView: {
                Image(systemName: "heart.fill")
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
