//
//  BeachPreviewView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct BeachPreviewCardView: View {
    let store: StoreOf<BeachPreviewCardStore>
    
    init(beach: Beach) {
        self.store = Store(
            initialState: BeachPreviewCardStore.State(beach: beach, information: nil),
            reducer: BeachPreviewCardStore()._printChanges()
        )
    }
    
    var body: some View {
        WithViewStore(store) { viewStore in
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        imageSection
                        
                        Spacer()
                        
                        learnMoreButton
                            .offset(y: 20)
                    }
                    
                    titleSection
                }
            }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
            .onAppear {
                viewStore.send(._requestInformation)
            }
        }
    }
}

struct BeachPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BeachPreviewCardView(beach: Beach(num: 1, name: "협재", address: "", longitude: 126.23994220041192, latitude: 33.394285064566915))
    }
}

extension BeachPreviewCardView {
    private var imageSection: some View {
        ZStack {
            WithViewStore(self.store.scope(state: \.information)) { information in
                AsyncImage(
                    url: information.state?.thumbnailPath,
                    transaction: Transaction(animation: .easeInOut(duration: 0.5))
                ) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(6)
                    case .empty:
                        Image("IconImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(6)
                        
                    case .failure:
                        ProgressView()
                    @unknown default:
                        ProgressView()
                    }
                }
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            WithViewStore(self.store.scope(state: \.beach)) { beach in
                Text(beach.name)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(beach.address)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var learnMoreButton: some View {
        Button {
            // TODO: - Navigate Button Action 추가하기
        } label: {
            Text("더보기")
                .font(.headline)
                .frame(width: 125, height: 35)
        }
        .background(Color.accentColor)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}