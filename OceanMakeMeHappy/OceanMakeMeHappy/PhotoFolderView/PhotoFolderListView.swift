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
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 200, alignment: .center)
                        .overlay {
                            Text(folder.name)
                                .foregroundColor(.white)
                        }
                    
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

struct PhotoListView_Previews: PreviewProvider {
    static let store = Store(
        initialState: PhotoFolderStore.State(),
        reducer: PhotoFolderStore()
    )
    static var previews: some View {
        NavigationView {
            PhotoFolderListView(store: store)
        }
    }
}
