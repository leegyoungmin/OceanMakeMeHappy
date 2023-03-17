//
//  BeachMapView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct BeachMapView: View {
    let store: StoreOf<BeachMapStore>
    
    init() {
        self.store = Store(
            initialState: BeachMapStore.State(),
            reducer: BeachMapStore()._printChanges()
        )
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            ZStack {
                IfLetStore(
                    store.scope(
                        state: \.mapStore,
                        action: BeachMapStore.Action.mapStore
                    )
                ) { store in
                    NaverMapView(store: store)
                        .edgesIgnoringSafeArea(.all)
                }
                
                previewCardSection(store: viewStore)
            }
            .task {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct BeachMapView_Previews: PreviewProvider {
    static var previews: some View {
        BeachMapView()
    }
}

extension BeachMapView {
    @ViewBuilder
    func previewCardSection(store: ViewStore<BeachMapStore.State, BeachMapStore.Action>) -> some View {
        VStack {
            Spacer()
            
            ZStack {
                IfLetStore(
                    self.store.scope(
                        state: \.selectedPreviewBeachState,
                        action: BeachMapStore.Action.previewCardAction
                    )
                ) { store in
                    BeachPreviewCardView(store: store)
                        .shadow(
                            color: Color.gray.opacity(0.3),
                            radius: 10
                        )
                        .padding()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                }
            }
        }
    }
}
