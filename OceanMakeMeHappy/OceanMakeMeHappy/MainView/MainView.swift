//
//  MainView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct MainView: View {
    let store: StoreOf<MainStore>
    
    init() {
        store = Store(initialState: MainStore.State(), reducer: MainStore())
    }
    var body: some View {
        NavigationView {
            WithViewStore(store) { viewStore in
                TabView(
                    selection: viewStore.binding(
                        get: \.selectedTab,
                        send: MainStore.Action.selectedTab
                    )
                ) {
                    Group {
                        Text("My Sea")
                            .tabItem {
                                Image(systemName: "photo.stack")
                                Text("나의 바다")
                            }
                            .tag(MainStore.State.Tab.mySea)
                        
                        BeachMapView(store: mapStore)
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                                Text("찾아보기")
                            }
                            .tag(MainStore.State.Tab.map)
                    }
                }
            }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

private extension MainView {
    var mapStore: Store<BeachMapStore.State, BeachMapStore.Action> {
        return store.scope(
            state: { $0.mapState },
            action: MainStore.Action.mapAction
        )
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
