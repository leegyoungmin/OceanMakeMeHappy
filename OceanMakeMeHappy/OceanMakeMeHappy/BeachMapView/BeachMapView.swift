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
                naverMapSection
                
                VStack {
                    Spacer()
                    
                    previewCardSection
                }
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

private extension BeachMapView {
    var naverMapSection: some View {
        IfLetStore(
            self.store.scope(
                state: \.mapStore,
                action: BeachMapStore.Action.mapStore
            )
        ) { store in
            NaverMapView(store: store)
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    var previewCardSection: some View {
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
