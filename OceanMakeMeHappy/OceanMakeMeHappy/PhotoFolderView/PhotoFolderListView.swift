//
//  PhotoView.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct PhotoFolderListView: View {
    let store: StoreOf<PhotoFolderStore>
    
    var body: some View {
        ScrollView {
            WithViewStore(store) { viewStore in
                ForEach(viewStore.folders, id: \.id) { folder in
                    NavigationLink {
                        Text(folder.name)
                    } label: {
                        folderCardView(folder)
                    }
                    .buttonStyle(FlatButtonStyle())
                }
                .padding()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                WithViewStore(store) { viewStore in
                    Button {
                        viewStore.send(.tapAddFolder)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .textFieldAlert(store)
        .onAppear {
            ViewStore(store).send(.onAppear)
        }
    }
}

extension PhotoFolderListView {
    var backgroundRoundRectangle: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(.white)
            .shadow(radius: 5)
    }
    
    @ViewBuilder
    func folderInformationView(_ folder: PhotoFolderStore.State.Folder) -> some View {
        VStack(spacing: .zero) {
            Spacer()
            
            HStack {
                VStack(alignment: .leading) {
                    Text(folder.name)
                        .font(.system(size: 28, weight: .black, design: .rounded))
                    
                    Text(folder.description ?? "")
                        .font(.headline)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .frame(height: 70)
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
    }
    
    
    @ViewBuilder
    func folderCardView(_ folder: PhotoFolderStore.State.Folder) -> some View {
        ZStack {
            backgroundRoundRectangle
            
            Image("IconImage")
                .resizable()
                .scaledToFill()
                .frame(height: 250, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            folderInformationView(folder)
        }
        .padding([.vertical], 5)
    }
}
