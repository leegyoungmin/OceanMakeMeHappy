//
//  ContentViewModel.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import Combine
import Foundation

final class ContentViewModel: ObservableObject {
    struct TabBarItem: Identifiable {
        let id = UUID()
        let title: String
        let imageName: String
        
        static var defaultList: [Self] = [
            TabBarItem(title: "", imageName: "map.fill"),
            TabBarItem(title: "설정", imageName: "person.circle.fill")
        ]
    }
    
    @Published var selectedIndex: Int = 0
    var tabBarItems: [TabBarItem] = TabBarItem.defaultList
    
    func isSelectedIndex(with index: Int) -> Bool {
        return selectedIndex == index
    }
}
