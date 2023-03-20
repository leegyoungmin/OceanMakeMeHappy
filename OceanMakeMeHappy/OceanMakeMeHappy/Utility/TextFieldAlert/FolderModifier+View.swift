//
//  FolderModifier+View.swift
//  OceanMakeMeHappy
//
//  Copyright (c) 2023 Minii All rights reserved.

import ComposableArchitecture
import SwiftUI

extension View {
    @ViewBuilder
    func textFieldAlert(
        _ store: StoreOf<PhotoFolderStore>
    ) -> some View {
        self.modifier(
            FolderModifier(store: ViewStore(store))
        )
    }
}
