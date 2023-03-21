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
                    FolderCardView(folder)
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
    }
}

extension PhotoFolderListView {
    @ViewBuilder
    func FolderCardView(_ folder: PhotoFolderStore.State.Folder) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(.white)
                .shadow(radius: 5)
            
            Image("IconImage")
                .resizable()
                .scaledToFill()
                .frame(height: 250, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
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
                .background(.white)
                .cornerRadius(12)
            }
        }
        .padding([.vertical], 5)
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static let store = Store(
        initialState: PhotoFolderStore.State(folders: [.init(name: "Example", description: "ExampleExampleExampleExampleExampleExampleExampleExampleExampleExampleExampleExampleExample"), .init(name: "Example2"), .init(name: "Example3")]),
        reducer: PhotoFolderStore()
    )
    static var previews: some View {
        Group {
            NavigationView {
                PhotoFolderListView(store: store)
            }
        }
        
    }
}
