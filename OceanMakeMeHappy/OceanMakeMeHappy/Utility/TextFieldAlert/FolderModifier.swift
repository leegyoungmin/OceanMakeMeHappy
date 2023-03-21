//
//  FolderModifier.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

struct FolderModifier: ViewModifier {
    let store: ViewStoreOf<PhotoFolderStore>
    
    init(store: ViewStoreOf<PhotoFolderStore>) {
        self.store = store
    }
    
    func body(content: Content) -> some View {
        content
            .alert(
                "폴더 추가",
                isPresented: store.binding(
                    get: \.isPresentAlert,
                    send: { _ in ._setAlertState(false) }
                )
            ) {
                TextField(
                    "폴더명을 입력해주세요.",
                    text: store.binding(
                        get: \.folderName,
                        send: PhotoFolderStore.Action._textChanged
                    )
                )
                
                Button("취소") {
                    store.send(._setAlertState(false))
                }
                
                Button("확인") {
                    store.send(.alertDismiss)
                }
            }
    }
}
