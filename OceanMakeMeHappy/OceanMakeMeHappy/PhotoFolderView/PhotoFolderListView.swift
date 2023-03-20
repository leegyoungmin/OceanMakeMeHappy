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
        WithViewStore(store) { viewStore in
            ScrollView {
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
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewStore.send(.tapAddFolder)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .alert(
                "폴더 추가",
                isPresented: viewStore.binding(
                    get: \.isPresentAlert,
                    send: { _ in ._setAlertState(false) }
                )
            ) {
                TextField(
                    "폴더명을 입력해주세요.",
                    text: viewStore.binding(
                        get: \.folderName,
                        send: PhotoFolderStore.Action._textChanged
                    )
                )
                
                Button("취소") {
                    viewStore.send(.alertDismiss)
                }
                
                Button("확인") {
                    viewStore.send(.alertDismiss)
                }
            }
        }
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
